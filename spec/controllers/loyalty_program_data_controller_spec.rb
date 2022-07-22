require 'rails_helper'

RSpec.describe LoyaltyProgramDataController, type: :controller do
  
  let(:user) {FactoryBot.create(:user)}
  let(:lp) {FactoryBot.create(:loyalty_program)}


  describe '#update' do
    it 'can be created' do
      expect(user).to be_valid
      expect(User.count).to eq(1)
      expect(User.first.name).to eq(user.name)
    end
  end

  # TODO : still not too sure how to write test to test account creation
  
end
