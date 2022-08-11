module CsvGeneratorHelper
  class CsvGeneratorHelper
    LOG_HEADERS = ['Transfer date', 'Amount', 'Reference number', 'Outcome code'].freeze

    def initialize; end

    def call(transfer_date, amount, reference_number, outcome_code)
      CSV.generate(headers: LOG_HEADERS, col_sep: ';', encoding: 'UTF-8') do |csv|
        csv << [transfer_date, amount, reference_number, outcome_code]
      end
    end
  end
end
