FactoryBot.define do
  factory :loyalty_program do
    loyalty_program_id { "id1"}
    program_name{ "Loyalty Program 1"}
    currency_name{ "Currency $1"}
    processing_time{ "2000-01-01 02:00:00"}
    description{ "Test Description"}
    enrollment_link {"www.google.com"}
    terms_and_conditions_link{ "www.facebook.com" }
  end
end