require 'rails_helper'

RSpec.describe LoyaltyProgram, type: :model do
  let(:user) do
    LoyaltyProgram.create(
        loyalty_program_id: "id1",
        program_name: "Loyalty Program 1",
        currency_name: "Currency $1",
        processing_time: "2000-01-01 02:00:00",
        description: "Test Description",
        enrollment_link: "www.google.com",
        terms_and_conditions_link: "www.facebook.com" 
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
