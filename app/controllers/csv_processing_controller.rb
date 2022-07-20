# This controller accepts a CSV file (handback) and processes it. It also allows generation of Accrual CSV files.
class CsvProcessingController < ApplicationController
  # def csv_file_path
  #   # give url to csv file
  #   @csv_file_path ||= File.read('https://...')
  # end

  def index
    
  end

  def upload_handback_csv
    process_handback(params[:csv_file_path])
  end

  def download_handback_csv
    # Downloads Handback CSV File from SFTP server
  end
  
  def upload_accrual_csv
    # Uploads accrual csv file to SFTP server
  end

  def process_handback(csv_file_path)
    # process csv file
    # save to database

    # get just the file name from file path
    csv_file_name = File.basename(csv_file_path)

    # split file name by undescore
    loyalty_program_id, handback_date = csv_file_name.split('_')
    handback_date = handback_date.split('.')[0]
    loyalty_program = LoyaltyProgram.where(loyalty_program_id: loyalty_program_id).first.id
    loyalty_program_data_id = LoyaltyProgramDatum.where(loyalty_program_id: loyalty_program).id

    # check csv if 'Account Id' column is present
    columns = CSV.read(csv_file_path, headers: true).headers
    # check if 'Account Id' column is present


    # end
    CSV.foreach(csv_file_path, headers: true) do |row|
      
      # continue to next row if outcome code is not success
      if !is_valid_transcation?(row['outcome_code'])
        next # TODO : Add error handling
      end
      account_id = row['Account Id'] || 1

      # create a new transcation in db
      txn = Transaction.new(
        date: row['Transfer Date'],
        loyalty_program_data_id: loyalty_program_data_id,
        amount: row['Amount'],
        status: "success",
        account_id: account_id,      # if row['Account Id'] is not present, use default value of 1
      ).save

      # update loyalty program data points
      Account.where(id: account_id).first.loyalty_program_data.where(loyalty_program_id: loyalty_program).first.update(points: row['Amount'])
    end
  end

  def generate_accrual_csv
    # generate accrual csv file
    # allow user to download the file
  end

  def get_status_from_outcome_code(outcome_code)
    # get status from outcome code
    case outcome_code
    when 0000, "0000"
      'success'
    when 0001, "0001"
      'member not found'
    when 0002, "0002"
      'member name mismatch'
    when 0003, "0003"
      'member account closed'
    when 0004, "0004"
      'member account suspended'
    when 0005, "0005"
      'member ineligible for accrual'
    when 0099, "0099"
      'unable to process, please contact support for more information'
    else
      'unknown outcome code'
    end


    end
  end

  def is_valid_transcation?(outcome_code)
    get_status_from_outcome_code(outcome_code) == 'success'
  end
end
