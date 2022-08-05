class LoyaltyProgramDatum < ApplicationRecord
    has_many :transactions
    # serialize :transaction_history, Array
        # has_many :transactions, class_name: "transactions", foreign_key: "loyalty_program_data_id"

    # Prevents Loyalty Program Datum from saving (The error says account must exists)
    # belongs_to :account, class_name: "Account", foreign_key: "account_id"
    has_one :loyalty_program, class_name: "LoyaltyProgram", foreign_key: "loyalty_program_id"

  # def update_amount
  #     # Add amount based on loyalty program id

  #     new_amount = Transactions.where(loya"#{time.year}#{"%02d" % time.month}#{"%02d" % time.day}"lty_program_id: loyalty_program_id).sum(:amount)

  #     #Assign this new ammount to LoyaltyProgramDatum that has the same loyalty_program_id
  #     self.points = new_amount

  #     save

  # end

  # def browse_transaction_history
  #     transaction_history
  # end
end
