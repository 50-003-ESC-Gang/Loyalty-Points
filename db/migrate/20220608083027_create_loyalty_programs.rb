class CreateLoyaltyPrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :loyalty_programs do |t|
      t.string :loyalty_program_id
      t.string :program_name
      t.string :currency_name
      t.time :processing_time
      t.text :description
      t.string :enrollment_link
      t.string :terms_and_conditions_link

      t.timestamps
    end
  end
end
