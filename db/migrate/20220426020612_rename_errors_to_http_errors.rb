class RenameErrorsToHttpErrors < ActiveRecord::Migration[7.0]
  def change
    change_table :data_transfers do |t|
      t.rename :errors, :http_errors
      add_column :data_transfers, :transfer_data_type, :string
    end
  end
end
