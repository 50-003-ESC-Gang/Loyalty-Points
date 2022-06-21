class Transaction < ApplicationRecord
    attr_readonly :amount, :loyalty_program_id

    validates :amount

    belongs_to: LoyaltyProgramDatum,


    after_create do
        LoyaltyProgramDatum.update_amount
    end

    
end
