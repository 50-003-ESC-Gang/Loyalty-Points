class LoyaltyProgram < ApplicationRecord
    after_create :create_loyalty_program_data

  def valid_membership(id)
    if membership_regex
      if id.match(membership_regex)
        puts 'Match found!'
        true
      else
        puts 'FAILEDDDD'
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
    User.all.each do |user|
      LoyaltyProgramDatum.create(account_id: user.account.id, loyalty_program_id: id)
    end
  end
end
