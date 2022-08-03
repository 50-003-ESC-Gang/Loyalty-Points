class LoyaltyProgram < ApplicationRecord
  after_create :create_loyalty_program_data

  def valid_membership(id)
    if membership_regex
      if id.match(membership_regex)
        puts 'Match found!'
        true
      else
        puts 'Match FAILED'
        false
      end
    else
      puts 'No Valid Regex'
      true
    end
  end

  private

  # create loyalty program data for all users
  def create_loyalty_program_data
    # This doubles the seeding that has been done in user.rb
    User.all.each do |user|
      puts "Creating loyalty program data for user #{user.id}"
      LoyaltyProgramDatum.create(account_id: user.account.id, loyalty_program_id: id)
    end
  end
end
