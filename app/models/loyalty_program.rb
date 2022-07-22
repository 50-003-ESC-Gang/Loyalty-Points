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
end
