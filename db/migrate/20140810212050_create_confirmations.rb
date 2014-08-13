class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :state
      t.integer :user_id

      t.timestamps
    end
    add_index :confirmations, [:state, :user_id]
  end
end
