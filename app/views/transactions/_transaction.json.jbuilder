json.extract! transaction, :id, :loyalty_program_id, :user_id, :transaction_date, :transactions_id, :amount, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
