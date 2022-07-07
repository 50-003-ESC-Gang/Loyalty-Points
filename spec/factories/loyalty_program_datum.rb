FactoryBot.define do
  factory :loyalty_program_data do
    account
    loyalty_program
    points { 1000 }
  end
  factory :loyalty_program_data_2 do
    account
    loyalty_program_2
    points { 1000 }
  end
end

def create_loyalty_program_data(account)
  FactoryBot.create(:loyalty_program_data, account: account, loyalty_program: FactoryBot.create(:loyalty_program),
                                           loyalty_program_2: FactoryBot.create(:loyalty_program_2))
end
