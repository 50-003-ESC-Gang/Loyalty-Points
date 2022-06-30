require 'rails_helper'

RSpec.describe LoyaltyProgram, type: :model do
  let(:lp) do
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
      expect(lp).to be_valid
      expect(LoyaltyProgram.count).to eq(1)
      expect(LoyaltyProgram.first.loyalty_program_id).to eq(lp.loyalty_program_id)
      expect(LoyaltyProgram.first.program_name).to eq(lp.program_name)
      expect(LoyaltyProgram.first.currency_name).to eq(lp.currency_name)
      expect(LoyaltyProgram.first.processing_time).to eq(lp.processing_time)
      expect(LoyaltyProgram.first.description).to eq(lp.description)
      expect(LoyaltyProgram.first.enrollment_link).to eq(lp.enrollment_link)
      expect(LoyaltyProgram.first.terms_and_conditions_link).to eq(lp.terms_and_conditions_link)
    end
  end

  describe 'update' do
    xit 'can change the password' do
    end

    xit 'can change the name' do
    end
  end
end
