require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:lp) do
    FactoryBot.create(:loyalty_program)
  end

  let(:user) do
    FactoryBot.create(:user)
  end

  context 'when happy case for create transaction' do
    it 'should create a transaction' do
      txn = Transaction.new(loyalty_program_data_id: lp.id, amount: 100, date: '2000-01-01 02:00:00', status: 'pending',
                            account_id: user.account.id)

      expect(txn).to be_valid
    end
  end
end
