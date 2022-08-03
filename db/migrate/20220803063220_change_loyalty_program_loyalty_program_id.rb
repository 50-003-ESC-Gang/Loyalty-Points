class ChangeLoyaltyProgramLoyaltyProgramId < ActiveRecord::Migration[7.0]
  def change
    change_column :loyalty_programs, :loyalty_program_id, :string
  end
end
