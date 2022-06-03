class DataTransfer < ApplicationRecord
  require "net/http"
  require "uri"
  require "json"

  SUCCESS_STATUS_C4 = 'pull from c4 success'
  SUCCESS_STATUS_C3 = 'post to c3 success'
  FAIL_STATUS_C4 = 'pull from c4 failed'
  FAIL_STATUS_C3 = 'post to c3 failed'

  after_initialize :set_entity
  after_create :call_worker 

  def C3_id
    return self.user_id
  end 

  def transfer
    puts "INITIALIZING TRANSFER..."
    c4_data = get_data_from_c4
    c3_data = @entity.prepare_data(c4_data)
    post_data_to_c3 c3_data
  end

  def c3_api_url
    "#{self.c3_url}/api/#{self.transfer_data_type.downcase}.json"
  end

  def c4_api_url
    "https://c4.imonggo.com/api/#{self.transfer_data_type.downcase}.json?page=#{self.page}"
  end

  def process_request(url, token, req_type="get", data=nil)
    #Request
    uri = URI(url)
    case req_type
      when 'get'
        req = Net::HTTP::Get.new(uri)
      when 'post'
        req = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json'})
        req.body = data
    end

    #API Token Handling
    req.basic_auth token, "password"

    # Handles HTTP Requests
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
    end 

    return res.body
  end

  # This is working!!!!
  def get_data_from_c4
    #TODO pull data from c4 and return json object
    json_obj = self.process_request(self.c4_api_url, self.c4_token)

    # Status Generator
    if true #TODO check if pull was successul
      update(status: SUCCESS_STATUS_C4)
    else
      errors = "" #TODO retrieve http error and set here
      update(status: FAIL_STATUS_C4, http_errors: errors)
    end
    return json_obj
  end
  
  def post_data_to_c3 c3
    #TODO post data to c3
    statuses = []
    c3.each do |response|
      r = JSON.parse(response)
      r['invoice']['user_id'] = self.user_id
      response = r.to_json

      req = process_request(self.c3_api_url, self.c3_token, 'post', response) 
      puts "Success?: #{req.is_a? Net::HTTPSuccess}"
      statuses.push(req)
      #puts "statuses: #{statuses}"
    end

    #Status Generator
    if true #TODO check if SUCCESS_STATUS_C3 was successul
      update(status: SUCCESS_STATUS_C4)
    else
      errors = "" #TODO retrieve http error and set here
      update(status: FAIL_STATUS_C4, http_errors: errors)
    end

    return statuses
  end

  def set_entity
    case transfer_data_type
      when 'Products'
        puts "Product is initialized!!!"
        @entity = Product.new
        puts "Entity is #{@entity}"
      when 'Invoices'
        puts "Invoice is initialized!!!"
        @entity = Invoice.new
        puts "Entity is #{@entity}"
        #TODO: add other entities here
      when 'Customers'
        puts "Customer is Initialized!!!"
        @entity = Customer.new
      when 'Users'
        @entity = User.new
      when 'Branches'
        @entity = Branch.new
    end
  end

  def call_worker
    DataTransferJob.perform_async(id)
  end

end
