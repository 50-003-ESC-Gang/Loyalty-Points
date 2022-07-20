class Transaction < ApplicationRecord
  # attr_readonly :amount, :loyalty_program

  validate :amount

  belongs_to :loyalty_program_data
  # belongs_to :receiver_data, class_name: "loyalty_program_datum", foreign_key: "receiver"

  has_one :user, through: :account, source: :index_account_on_user_id
  enum :status, %i[pending success failed cancelled]

end
