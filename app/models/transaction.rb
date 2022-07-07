class Transaction < ApplicationRecord
  # attr_readonly :amount, :loyalty_program

  validate :amount

  belongs_to :loyalty_program_data, class_name: "loyalty_program_datum", foreign_key: "loyalty_program_datum_id"
  belongs_to :receiver_data, class_name: "loyalty_program_datum", foreign_key: "receiver"

  has_one :user, through: :account, source: :index_account_on_user_id

  enum :status, %i[pending success failed cancelled]
# TODO : transcation.rb should not handle the points logic. Rather it should be the controller that processes these transcations right
  after_create do
    if self.status == "success"
      self.loyalty_program_data.points += self.amount
      self.receiver_data.points -= self.amount
    end
    
  end
end
