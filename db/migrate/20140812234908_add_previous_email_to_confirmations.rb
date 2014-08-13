class AddPreviousEmailToConfirmations < ActiveRecord::Migration
  def change
  	add_column :confirmations, :previous_email, :string
  end
end
