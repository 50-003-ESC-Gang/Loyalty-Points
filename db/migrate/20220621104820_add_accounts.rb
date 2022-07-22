class AddAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :account do |t|
      t.belongs_to :user, foreign_key: true
    end
   

    add_reference :loyalty_program_data, :account, index: true
    add_foreign_key :loyalty_program_data, :account
  end
end
