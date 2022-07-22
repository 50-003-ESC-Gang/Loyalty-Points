require 'rails_helper'

RSpec.describe LoyaltyProgramDataController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:lp) { FactoryBot.create(:loyalty_program) }
  let(:lpd) { FactoryBot.create(:loyalty_program_datum, account_id: user.id, loyalty_program_id: lp.id) }

  describe '#index' do
    it 'should return loyalty program data for user account' do
      sign_in user

      get :index, params: { id: user.id }
      expect(response).to have_http_status(200)
    end
  end

  describe '#update' do
    context 'when happy case' do
      xit 'should update loyalty program data points' do
      end
    end
  end

  # TODO : still not too sure how to write test to test account creation
end
