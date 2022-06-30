require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    # Account is creted when User is created
    FactoryBot.create(:user)
  end
  let(:account) do
    user.account
  end
  describe 'account creation' do
    it 'should create an account' do
      expect(account).to be_valid
      expect(account.user).to eq(user)
    end
  end
end
