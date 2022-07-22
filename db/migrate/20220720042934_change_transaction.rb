class ChangeTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :loyalty_program_datum_id, :integer
    remove_column :transactions, :loyalty_program_data_id, :integer
    remove_column :transactions, :date
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
