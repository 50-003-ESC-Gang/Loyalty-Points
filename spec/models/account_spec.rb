require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'account creation' do
    let(:user) do
      # Account is creted when User is created
      FactoryBot.create(:user)
    end
    let(:account) do
      user.account
    end
    it 'should create an account' do
      expect(account).to be_valid
      expect(account.user).to eq(user)
    end
  end
  describe 'account creation with factory bot' do
    let(:account) do
      FactoryBot.create(:account)
    end
    it 'should create an account' do
      expect(account).to be_valid
      account.user.password.should eq("password@1234")
    end
  end
  describe 'account with loyalty program points' do
  end
end
