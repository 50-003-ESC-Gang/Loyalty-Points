require 'rails_helper'

RSpec.describe LoyaltyProgramDatum, type: :model do
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:lp) do
    FactoryBot.create(:loyalty_program)
  end

  context 'when happy case for create loyalty_program_datum' do
    it 'should create a loyalty_program_datum' do
      initial_count = LoyaltyProgramDatum.count

      LoyaltyProgramDatum.create(account_id: user.account.id,
                                 loyalty_program_id: lp.id)
      expect(LoyaltyProgramDatum.count).to eq(initial_count + 1)
    end
  end

  # TODO: Refer to https://github.com/50-003-ESC-Gang/Loyalty-Points/issues/86
  # context 'when loyalty program is created' do
  #   xit 'should create a loyalty program data for user' do
  #     expect(LoyaltyProgramDatum.count).to eq(0)
  #     debugger
  #     FactoryBot.create(:loyalty_program)

  #     expect(LoyaltyProgramDatum.count).to eq(1)
  #     expect(LoyaltyProgramDatum.first.loyalty_program_id).to eq(lp.loyalty_program_id)
  #   end
  # end
end
