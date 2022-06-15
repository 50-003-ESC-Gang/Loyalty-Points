class LoyaltyProgramDatum < ApplicationRecord
    serialize :transaction_history, Array
    
end
