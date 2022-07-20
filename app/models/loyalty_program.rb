class LoyaltyProgram < ApplicationRecord

    def valid_membership(id)
        if membership_regex
            if id.match(membership_regex)
                puts "Match found!"
                return true
            else
                puts "FAILEDDDD"
                return false
            end
        else
          puts "No Valid Regex"
          return true
        end
    end
  after_create :create_loyalty_program_data

  # create loyalty program data for all users
  def create_loyalty_program_data
    User.all.each do |user|
      LoyaltyProgramDatum.create(account_id: user.account.id, loyalty_program_id: self.id)
    end
  end
end
