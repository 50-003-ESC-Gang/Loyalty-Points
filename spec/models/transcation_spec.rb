require 'rails_helper'

RSpec.describe Transcation, type: :model do
  describe '#create' do
    let(:lp) do
      FactoryBot.create(:loyalty_program)
    end
    let(:lp2) do
      FactoryBot.create(:loyalty_program_2)
    end

    let(:user) do
      FactoryBot.create(:user)
    end

    let(:account) { user.account }

    context 'when transcation is successful' do
      xit 'should create a transcation' do
        # transcation = create_loyalty_program_data()
        xit 'should decrease the points of the sender' do
          # Loyalty Program data in account for sending lp should decrease
        end
        xit 'should increase the points of the receiver' do
          # Loyalty Program data in account for sending lp should increase
        end
      end
    end
  end
end
