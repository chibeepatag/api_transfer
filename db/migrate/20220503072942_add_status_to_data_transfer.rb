class AddStatusToDataTransfer < ActiveRecord::Migration[7.0]
  def change
    change_table :data_transfers do |t|
      add_column :data_transfers, :status, :string, limit: 100
    end
  end
end
