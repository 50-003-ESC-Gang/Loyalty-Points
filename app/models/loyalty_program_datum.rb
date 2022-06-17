class LoyaltyProgramDatum < ApplicationRecord
    has_many: Transaction
    serialize :transaction_history, Array

    
end
