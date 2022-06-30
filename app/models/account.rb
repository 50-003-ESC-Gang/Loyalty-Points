# Account Model handles details of the user account regarding loyalty program

class Account < ApplicationRecord
  belongs_to :user
  # has_many :loyalty_program_datum
  has_many :loyalty_program_data, class_name: 'LoyaltyProgramDatum', foreign_key: 'account_id'
  after_create :create_loyalty_program_data

  def create_loyalty_program_data
    # creating loyalty program data for account for each loyalty program in callback
    loyalty_program_id = LoyaltyProgram.all.pluck(:id) # Use #pluck as a shortcut to select one or more attributes without loading a bunch of records just to grab the attributes you want

    # build loyalty program data for each loyalty program

    loyalty_program_id.each do |i|
      byebug
      user.account.loyalty_program_data.build(loyalty_program_id: i).save
    end
  end
end
