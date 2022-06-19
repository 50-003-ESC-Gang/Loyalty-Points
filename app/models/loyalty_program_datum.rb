class LoyaltyProgramDatum < ApplicationRecord
    has_many: Transaction, foreign_key: "loyalty_program_id"
    serialize :transaction_history, Array


    def update_amount
        # Add amount based on loyalty program id

        new_amount = transactions.where(loyalty_program_id: loyalty_program_id).sum(:amount)
        
        #Assign this new ammount to LoyaltyProgramDatum that has the same loyalty_program_id
        self.points = new_amount

        save

    end

    def browse_transaction_history
        transaction_history
    end



    
end





