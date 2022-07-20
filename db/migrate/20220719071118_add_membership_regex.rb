class AddMembershipRegex < ActiveRecord::Migration[7.0]
  def change
    add_column :loyalty_programs, :membership_regex, :string
  end
end
