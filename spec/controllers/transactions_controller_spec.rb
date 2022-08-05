require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:lp) { FactoryBot.create(:loyalty_program) }
  let(:lpd) do
    FactoryBot.create(:loyalty_program_datum, account_id: user.account.id, loyalty_program_id: lp.loyalty_program_id)
  end

  before(:each) do
    sign_in user
  end

  describe 'creation' do
    context 'when valid params are passed' do
      it 'transaction can be created' do
        transaction_params = {
          account_id: user.account.id,
          loyalty_program_datum_id: lpd.id,
          amount: 100
        }
        post :create, params: { transaction: transaction_params }
        expect(response).to have_http_status(302)
        
        expect(flash[:notice]).to eq('Transaction was successfully created.')
        expect(Transaction.count).to eq(1)
      end
    end
    context 'when invalid params are passed' do
      it 'transaction cannot be created' do
        transaction_params = {
          account_id: user.account.id,
          loyalty_program_id: lp.id,
          points: 100
        }
        post :create, params: { transaction: transaction_params }
        expect(response).to have_http_status(422)
        expect(Transaction.count).to eq(0)
      end
    end
  end
  describe 'update' do
    context 'when valid params are passed' do
      it 'transaction can be updated' do
        # create a transaction
        Transaction.create(account_id: user.account.id, loyalty_program_datum_id: lpd.id, amount: 100)

        # update the transaction with valid params
        transaction_params = {
          account_id: user.account.id,
          loyalty_program_datum_id: lpd.id,
          amount: 200
        }

        post :update, params: { id: 1, transaction: transaction_params }
        expect(Transaction.find(1).amount).to eq(200)

      end
    end

  end
end
