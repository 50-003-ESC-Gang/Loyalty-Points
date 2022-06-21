class Account < ApplicationRecord
  belongs_to :user
  has_many :loyalty_program_datum, class_name: "loyalty_program_data", foreign_key: "reference_id"
end
