class CreateDataTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :data_transfers do |t|
      t.string :c4_acct_name
      t.string :c4_token
      t.string :c3_acct_name
      t.string :c3_url
      t.integer :page
      t.timestamp :job_start_time
      t.timestamp :job_end_time
      t.text :errors

      t.timestamps
    end
  end
end
