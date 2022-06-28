class Account < ApplicationRecord
  belongs_to :user
  has_many :loyalty_program_datum, class_name: 'loyalty_program_data', foreign_key: 'reference_id'
  after_create :create_loyalty_program_data

  def create_loyalty_program_data
    # Account.
    byebug
    @loyalty_program_data = user.account.build_loyalty_program_datum(points: 0).save
  end
end
