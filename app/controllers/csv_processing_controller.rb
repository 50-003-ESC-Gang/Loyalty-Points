# This controller accepts a CSV file (handback) and processes it. It also allows generation of Accrual CSV files.
class CsvProcessingController < ApplicationController
  # def csv_file_path
  #   # give url to csv file
  #   @csv_file_path ||= File.read('https://...')
  # end
  def upload_handback_csv
    process_handback(params[:csv_file_path])
  end

  def process_handback(csv_file_path)
    # process csv file
    # save to database
    # redirect to index page
    # @csv ||= CSV.parse(csv_file_path, col_sep: ',', row_sep: :auto, skip_blanks: true)

    # @csv.each_with_index do |row, index|
    #   next if index.zero # skip headers

    # end
    CSV.foreach(csv_file_path, headers: true) do |row|
      txn = Transaction.new(
        row['loyalty_program_id'],
        row['program_name'],
        row['description'],
        row['enrollment_link'],
        row['terms_and_conditions_link'],
        row['currency_name'],
      )
    end
  end

  def generate_accrual_csv
    # generate accrual csv file
    # allow user to download the file
  end
end
