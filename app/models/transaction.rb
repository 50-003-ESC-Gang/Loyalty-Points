class Transaction < ApplicationRecord
    # attr_readonly :amount, :loyalty_program

    validate :amount

    belongs_to :loyalty_program
    # has_one :user, through: :account, source: :account_table_foreign_key_to_user_table

    after_create do
        LoyaltyProgramDatum.update_amount
    end

    
end
