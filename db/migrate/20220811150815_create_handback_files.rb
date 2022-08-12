class CreateHandbackFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :handback_files do |t|
      t.string :transfer_date
      t.string :amount
      t.string :reference_number
      t.string :outcome_code
    end
  end
end
