class AccrualProcessor < Rails::Application
  @@current_index = 1
  @@FOLDER_ACCRUAL = './tmp/accruals/'
  @@FOLDER_HANDBACK = './tmp/handbacks/'

  def self.convert_to_accrual(transaction)
    time = Time.new
    date_str1 = "#{time.year}#{time.month}#{time.day}" # YYYYMMDD format, used for file name
    date_str2 = "#{time.year}-#{time.month}-#{time.day}" # YYYY-MM-DD format, used for csv field
    company_code = transaction.loyalty_program_datum.loyalty_program_id
    filepath = "#{@@FOLDER_ACCRUAL}#{company_code}_#{date_str1}.txt"
    puts "accrual file path: #{filepath}"
    # handback_name = "#{company_code}_#{date_str1}.HANDBACK.txt"
    handback_name = 'id0_20200801.HANDBACK.txt'

    if !File.exist?(filepath) or File.zero?(filepath)
      new_file = File.new(filepath, 'w')
      new_file.syswrite("index,Member ID,Member first name,Member last name,Transfer date,Amount,Reference number,Partner code\n")
      @@current_index = 1
      new_file.close
      SendAccrualJob.perform_later(filepath)
      DownloadHandbackJob.set(wait_until: Date.tomorrow.midnight).perform_later(handback_name, @@FOLDER_HANDBACK)
    end
    accrual_file = File.open(filepath, 'a')
    # using transaction's id as ref number
    accrual_file.syswrite("#{@@current_index},#{transaction.loyalty_program_datum.account.id},#{transaction.loyalty_program_datum.account.user.name},#{transaction.loyalty_program_datum.account.user.lastname},#{date_str2},#{transaction.amount},#{date_str1}#{transaction.id},#{company_code}\n")

    accrual_file.close
    DownloadHandbackJob.perform_later(handback_name, @@FOLDER_HANDBACK)
  end

  def self.process_handback(csv_file_path)
    # process csv file
    # save to database

    # get just the file name from file path
    csv_file_name = File.basename(csv_file_path)

    # split file name by undescore
    loyalty_program_id, handback_date = csv_file_name.split('_')
    handback_date = handback_date.split('.')[0]
    puts loyalty_program_id
    loyalty_program = LoyaltyProgram.where(loyalty_program_id: loyalty_program_id).first.id
    # loyalty_program_data_id = LoyaltyProgramDatum.where(loyalty_program_id: loyalty_program).id

    # check csv if 'Account Id' column is present
    columns = CSV.read(csv_file_path, headers: true).headers
    # check if 'Account Id' column is present

    # end
    CSV.foreach(csv_file_path, headers: true) do |row|
      # continue to next row if outcome code is not success
      unless is_valid_transcation?(row['outcome_code'])
        next # TODO : Add error handling
      end

      account_id = row['Account Id'] || 1

      #   # create a new transcation in db
      #   txn = Transaction.new(
      #     date: row['Transfer Date'],
      #     loyalty_program_data_id: loyalty_program_data_id,
      #     amount: row['Amount'],
      #     status: 'success',
      #     account_id: account_id # if row['Account Id'] is not present, use default value of 1
      #   ).save

      # updaate transaction status in db
      transaction = Transaction.where(id: row['Reference number'])
      transaction.update(status: get_status(row['Outcome code']))

      # update loyalty program data points
      acc = Account.where(id: account_id).first
      acc.loyalty_program_data.where(loyalty_program_id: loyalty_program).first.update(points: row['Amount'])

      #Email user
      StatusMailer.with(user: acc.user, transaction_id: transaction.id).status_email.deliver_now
      #https://guides.rubyonrails.org/action_mailer_basics.html

    end
  end

  def get_status(outcome_code)
    # get status from outcome code
    case outcome_code
    when 0o000, '0000'
      'success'
    when 0o001, '0001'
      'member not found'
    when 0o002, '0002'
      'member name mismatch'
    when 0o003, '0003'
      'member account closed'
    when 0o004, '0004'
      'member account suspended'
    when 0o005, '0005'
      'member ineligible for accrual'
    when '0099'
      'unable to process, please contact support for more information'
    else
      'unknown outcome code'
    end
  end

  def is_valid_transcation?(outcome_code)
    get_status(outcome_code) == 'success'
  end
end
