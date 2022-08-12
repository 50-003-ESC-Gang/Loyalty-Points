FactoryBot.define do
  factory :fuzz_csv do
    transfer_date { Faker::Time.between(from: 2.years.ago, to: 2.years.since) }
    amount { Faker::Number.between(from: 0.0, to: 1000.0).round(2) }
    reference_number { Faker::Number.between(from: 0, to: 100) }
    # 4 digit number from 0000 to 9999
    outcome_code { Faker::Number.between(from: 0, to: 9999).to_s.rjust(4, '0') }
  end
end
