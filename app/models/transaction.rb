class Transaction < ApplicationRecord
    # attr_readonly :amount, :loyalty_program

    validate :amount

    belongs_to :account
    has_one :user, through: :account, source: :index_account_on_user_id

    enum :status, [ :pending, :success, :failed, :cancelled ]

    after_create do
        LoyaltyProgramDatum.update_amount
    end

    
end
