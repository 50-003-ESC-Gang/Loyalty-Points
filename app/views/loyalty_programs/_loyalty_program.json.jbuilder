json.extract! loyalty_program, :id, :loyalty_program_id, :program_name, :currency_name, :processing_time, :description, :enrollment_link, :terms_and_conditions_link, :created_at, :updated_at
json.url loyalty_program_url(loyalty_program, format: :json)
