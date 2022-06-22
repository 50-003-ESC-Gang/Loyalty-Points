class LoyaltyProgramDatum < ApplicationRecord
    has_many :transactions, class_name: "transactions", foreign_key: "reference_id"
    # serialize :transaction_history, Array
    belongs_to :account, class_name: "account", foreign_key: "account_id"
    has_one :loyalty_program, class_name: "loyalty_program", foreign_key: "loyalty_program_id"

    def update_amount
        # Add amount based on loyalty program id

        new_amount = Transactions.where(loyalty_program_id: loyalty_program_id).sum(:amount)
        
        #Assign this new ammount to LoyaltyProgramDatum that has the same loyalty_program_id
        self.points = new_amount

        save

    end

    # def browse_transaction_history
    #     transaction_history
    # end

    
end





