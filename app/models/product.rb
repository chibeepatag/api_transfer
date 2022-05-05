class Product
  require "json"

  # Note that tax_rates, utc_created_at, status, minimum_quantity, maximum_quantity are READ-ONLY
  # barcode_array attribute is only found on C3 Accounts!
  TRANSFER_ATTRIBUTES = ["disable_discount", "cost", "allow_decimal_quantities", "tag_list", "retail_price", "name", "tax_exempt", "barcode_list", "disable_inventory", "stock_no", "enable_open_price", "description"]

  # Deals with one JSON entry from the GET Request
  def prepare_data c4_json
    requests = []
    JSON.parse(c4_json).each do |e|
      prod = Hash.new
      entry = Hash.new
      TRANSFER_ATTRIBUTES.each do |t|
          entry[t] = e[t]
      end
      prod['product'] = entry
      requests.push(prod.to_json)
    end
    return requests
  end

end