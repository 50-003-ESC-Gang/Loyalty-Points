class ChangeDataTypeForTranscation < ActiveRecord::Migration[7.0]
  def up
    change_table :transactions do |t|
      t.change :loyalty_program_id_id, :integer
    end
  end
  def down
    change_table :transactions do |t|
      t.change :loyalty_program_id_id, :string
    end
  end
end
