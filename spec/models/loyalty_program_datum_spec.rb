require 'rails_helper'

RSpec.describe LoyaltyProgramDatum, type: :model do
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:lp) do
    FactoryBot.create(:loyalty_program)
  end

  describe '#create' do
    it 'should create a loyalty_program_datum' do
      lp_id = lp.id
      account_id = user.account.id
      initial_count = LoyaltyProgramDatum.count

      LoyaltyProgramDatum.create(account_id: account_id,
                                 loyalty_program_id: lp_id)
      expect(LoyaltyProgramDatum.count).to eq(initial_count + 1)
    end
  end

  # TODO: Refer to https://github.com/50-003-ESC-Gang/Loyalty-Points/issues/86
  context 'when loyalty program is created' do
    it 'should create a loyalty program data for all user' do
      # initial_count = LoyaltyProgramDatum.count
      lp_id = 'id-test-id'
      lp = LoyaltyProgram.create(loyalty_program_id: lp_id)

      user = User.all

      # check if loyalty program data is created for all users
      user.each do |curr_user|
        # check if loyalty program data is created for each user
        expect(LoyaltyProgramDatum.where(account_id: curr_user.account.id, loyalty_program_id: lp_id).count).to eq(1)
      end
    end
  end

  context 'when user is created' do
    it 'should create all loyalty program data for the user' do
      initial_count = LoyaltyProgramDatum.count
      lp_id = 'id-test-id'
      lp = LoyaltyProgram.create(loyalty_program_id: lp_id)

      user = User.all

      # check if loyalty program data is created for all users
      user.each do |curr_user|
        # check if loyalty program data is created for each user
        expect(LoyaltyProgramDatum.where(account_id: curr_user.account.id, loyalty_program_id: lp.id).count).to eq(1)
      end

      # expect(LoyaltyProgramDatum.count).to eq(1)
      # expect(LoyaltyProgramDatum.first.loyalty_program_id).to eq(lp.loyalty_program_id)
    end
  end
end
