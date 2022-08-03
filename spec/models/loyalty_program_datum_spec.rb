require 'rails_helper'

RSpec.describe LoyaltyProgramDatum, type: :model do
    let(:user) do
      FactoryBot.create(:user)
    end

    let(:user2) do
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
      users = [user, user2]

      # check if loyalty program data is created for all users
      users.each do |curr_user|
        # check if loyalty program data is created for each user
        expect(LoyaltyProgramDatum.where(account_id: curr_user.account.id, loyalty_program_id: lp.id).count).to eq(1)
      end
    end
  end

  context 'when 1 user is created with 1 loyalty program' do
    it 'should create 1 loyalty program data for the user' do

      # check if loyalty program data is created for 1 user
      expect(LoyaltyProgramDatum.where(account_id: user.account.id, loyalty_program_id: lp.id).count).to eq(1)

    end
  end

    context 'when 2 users is created with 2 loyalty program' do
    it 'should create 1 loyalty program data for each of the user' do
      initial_count = LoyaltyProgramDatum.count
      lp2 = LoyaltyProgram.create(
        loyalty_program_id: "12s",
        program_name: "Loyalty Program 12s",
        currency_name: "Currency $12s",
        processing_time: '2000-01-01 02:00:00',
        description: 'Test Description',
        enrollment_link: 'www.google.com',
        terms_and_conditions_link: 'www.facebook.com'
      )

      users = [user, user2]
      
      # check if loyalty program data is created for all users
      users.each do |curr_user|
        # check if loyalty program data is created for each user
        expect(LoyaltyProgramDatum.where(account_id: curr_user.account.id).count).to eq(2)
      end

    end

    # Test for multiple user and multiple programs
  end
end
