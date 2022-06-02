class AddUserIdToDataTransfers < ActiveRecord::Migration[7.0]
  def change
    change_table :data_transfers do |t|
      add_column :data_transfers, :user_id, :integer
    end
  end
end
