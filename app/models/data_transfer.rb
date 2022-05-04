class DataTransfer < ApplicationRecord

  SUCCESS_STATUS_C4 = 'pull from c4 success'
  SUCCESS_STATUS_C3 = 'post to c3 success'
  FAIL_STATUS_C4 = 'pull from c4 failed'
  FAIL_STATUS_C3 = 'post to c3 failed'

  after_initialize  :set_entity
  #after_create :call_worker 

  def transfer
    c4_data = get_data_from_c4
    c3_data = @entity.prepare_data(c4_data)
    post_data_to_c3 data
  end

  def get_data_from_c4
    #TODO pull data from c4 and return json object
    if true #TODO check if pull was successul
      update(status: SUCCESS_STATUS_C4)
    else
      errors = "" #TODO retrieve http error and set here
      update(status: FAIL_STATUS_C4, http_errors: errors)
    end
  end

  def post_data_to_c3 c3
    #TODO post data to c3
    if true #TODO check if SUCCESS_STATUS_C3 was successul
      update(status: SUCCESS_STATUS_C4)
    else
      errors = "" #TODO retrieve http error and set here
      update(status: FAIL_STATUS_C4, http_errors: errors)
    end
  end

  def set_entity
    case transfer_data_type
    when 'products'
      @entity = Product.new
    when 'invoices'
      @entity = Invoice.new
      #TODO: add other entities here
    end
  end

  def call_worker
    DataTransferJob.perform_async(id)
  end


end
