class AccrualProcessor < Rails::Application
  # @@current_index = 1
  @@CURRENT_INDICES = {}
  @@FOLDER_ACCRUAL = './tmp/accruals/'
  @@FOLDER_HANDBACK = './tmp/handbacks/'

  def self.convert_to_accrual(transaction)
    date_str1, date_str2, company_code, filepath, handback_name = get_names(transaction)

    if !File.exist?(filepath) or File.zero?(filepath)
      create_new_accrual(date_str1, date_str2, company_code, filepath, handback_name)
      # creating new accrual csv triggers setting up the send&retrieve task
      # time needs to be set properly here
      set_jobs(date_str1, date_str2, company_code, filepath, handback_name)
    end
    write_accrual(date_str1, date_str2, company_code, filepath, handback_name, transaction)
  end

  def get_names(transaction)
    time = Time.new
    date_str1 = "#{time.year}#{'%02d' % time.month}#{'%02d' % time.day}" # YYYYMMDD format, used for file name
    date_str2 = "#{time.year}-#{'%02d' % time.month}-#{'%02d' % time.day}" # YYYY-MM-DD format, used for csv field
    company_code = transaction.loyalty_program_id # loyalty_program_id is used as foreign key of lp inside lpd, and is supposed to be string representing the company
    filepath = "#{@@FOLDER_ACCRUAL}#{company_code}_#{date_str1}.txt"
    handback_name = "#{company_code}_#{date_str1}.HANDBACK.txt"

    [date_str1, date_str2, company_code, filepath, handback_name]
  end

  def create_new_accrual(_date_str1, _date_str2, company_code, filepath, _handback_name)
    new_file = File.new(filepath, 'w')
    new_file.syswrite("index,Member ID,Member first name,Member last name,Transfer date,Amount,Reference number,Partner code\n")
    @@CURRENT_INDICES[company_code] = 1
    new_file.close
  end

  def set_jobs(_date_str1, _date_str2, _company_code, filepath, handback_name)
    # SendAccrualJob.set(wait_until: Date.tomorrow.noon).perform_later(filepath)
    SendAccrualJob.perform_later(filepath) # for demonstration
    # DownloadHandbackJob.set(wait_until: Date.tomorrow.midnight).perform_later(handback_name, @@FOLDER_HANDBACK)
    DownloadHandbackJob.perform_later(handback_name, @@FOLDER_HANDBACK) # for demonstration
  end

  def write_accrual(_date_str1, date_str2, company_code, filepath, _handback_name, transaction)
    accrual_file = File.open(filepath, 'a+')
    # using transaction's id as ref number
    # transaction attribute->csv field mapping:
    # member id->txn.lpd.account.id
    # member first name ->txn.lpd.account.user.name
    # member last name -> txn.lpd.account.user.lastname
    # transfer date->date_str2
    # amount->txn.amount
    # reference number->txn.id
    # partner code->txn.lpd.lp_id
    user = User.where(id: transaction.account_id).first # seems that this account id is actually user id
    user_first_name = user.name
    user_last_name = user.lastname
    member_id = user.id
    #  handling unexpected loss of index, possibly due to saving changed code
    @@CURRENT_INDICES[company_code] = accrual_file.readlines.length if @@CURRENT_INDICES[company_code].nil?
    accrual_file.syswrite("#{@@CURRENT_INDICES[company_code]},#{member_id},#{user_first_name},#{user_last_name},#{date_str2},#{transaction.amount},#{transaction.id},#{company_code}\n")
    # increment the index
    @@CURRENT_INDICES[company_code] += 1
    accrual_file.close
  end

  def self.process_handback(csv_file_path)
    # process csv file
    # save to database

    # get just the file name from file path
    csv_file_name = File.basename(csv_file_path)

    # split file name by undescore
    # debugger
    loyalty_program_id, handback_date = csv_file_name.split('_')
    handback_date = handback_date.split('.')[0]
    loyalty_program = LoyaltyProgram.where(loyalty_program_id: loyalty_program_id).first.id

    columns = CSV.read(csv_file_path, headers: true).headers

    CSV.foreach(csv_file_path, headers: true) do |row|
      begin
        # updaate transaction status in db
        txn = Transaction.where(id: row['Reference number']).first
        txn.update(status: get_status(row['Outcome code']))

        if get_status(row['Outcome code']) == 'success'
          # update LoyaltyProgramDatum points
          LoyaltyProgramDatum.where(id: txn.loyalty_program_datum_id).first.update(points: row['Amount'])
        end
      rescue StandardError # exception type?
        puts 'transaction not found'
        next
      end

      # Email user
      user = User.where(id: txn.account_id).first # account_id is actually id for user
      acc = user.account
      StatusMailer.with(user: acc.user, transaction_id: txn.id).status_email.deliver_now
      # https://guides.rubyonrails.org/action_mailer_basics.html
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

  def valid_transcation?(outcome_code)
    get_status(outcome_code) == 'success'
  end

  def self.get_CURRENT_INDICES
    @@CURRENT_INDICES.dup
  end
end
