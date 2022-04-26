class AddAttributeToModel < ActiveRecord::Migration[7.0]
  def change
    add_column :models, :transfer_data_type, :string
  end
end
