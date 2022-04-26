class DataTransferJob
  include Sidekiq::Job

  def perform(data_transfer_id=1)
    data_transfer = DataTransfer.find data_transfer_id
    data_transfer.transfer
  end
end
