require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create(
      email: 'foo@bar.net',
      name: 'baz',
      lastname: 'qux',
      password: 'chicken',
      password_confirmation: 'chicken'
    )
  end

  describe 'creation' do
    it 'can be created' do
      expect(user).to be_valid
      expect(User.count).to eq(1)
      expect(User.first.name).to eq(user.name)
    end
  end

  describe 'update' do
    xit 'can change the password' do
    end

    xit 'can change the name' do
    end
  end
end
