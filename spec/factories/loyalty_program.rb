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
  factory :loyalty_program_2 do
    loyalty_program_id { "id2"}
    program_name{ "Loyalty Program 2"}
    currency_name{ "Currency $2"}
    processing_time{ "2000-02-02 02:00:00"}
    description{ "Test Description"}
    enrollment_link {"www.google.com"}
    terms_and_conditions_link{ "www.facebook.com" }
  end
end