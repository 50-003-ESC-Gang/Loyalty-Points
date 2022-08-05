require 'rails_helper'

RSpec.describe LoyaltyProgramDataController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:lp) { FactoryBot.create(:loyalty_program) }
  # let(:lpd) { FactoryBot.create(:loyalty_program_datum, account_id: user.id, loyalty_program_id: lp.id) }

  before(:each) do
    sign_in user
  end

  describe '#index' do
    it 'should return loyalty program data for user account' do
      get :index, params: { id: user.id }
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    context 'when inappropriate params are passed' do
      it 'should not create a loyalty program data for user account' do
        loyalty_program_data_params = {
          points: 100
        }
        post :create, params: { loyalty_program_datum: loyalty_program_data_params }
        expect(LoyaltyProgramDatum.count).to eq(1)
      end
    end
    context 'when appropriate params are passed' do
      xit 'should create a loyalty program data for user account' do
        initial_count = LoyaltyProgramDatum.count
        loyalty_program_data_params = {
          loyalty_program_id: lp.id,
          points: 100
        }

        post :create, params: { loyalty_program_datum: {
          loyalty_program_id: lp.id,
          points: 100
        } }
      end
    end
  end

  describe '#update' do
    context 'when happy case' do
      it 'should update loyalty program data points' do
        post :update,
             params: { id: lp.id,
                       loyalty_program_datum: { loyalty_program_id: lp.loyalty_program_id, in_points: 1000,
                                                points: 0 } }
        # expect(response).to have_http_status(200)

        expect(LoyaltyProgramDatum.where(loyalty_program_id: lp.loyalty_program_id,
                                         account_id: user.account.id).first.points).to eq(1000)
        # expect flash notice to be present
        expect(flash[:notice]).to be_present
      end
    end
  end

  # TODO : still not too sure how to write test to test account creation
end
