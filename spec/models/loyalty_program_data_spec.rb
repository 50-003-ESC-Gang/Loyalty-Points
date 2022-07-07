require 'rails_helper'

RSpec.describe LoyaltyProgramDatum, type: :model do
  describe 'loyalty program data creation' do
    let(:account) { FactoryBot.create(:account) }
    let(:loyalty_program_data) do
      FactoryBot.create_loyalty_program_data(account)
    end
    it 'should create an account' do
      expect(account).to be_valid
    end
    it 'should create a loyalty program data' do
      expect(loyalty_program_data).to be_valid
    end
  end
end
