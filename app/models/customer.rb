class Customer 
    require "json"
    CUSTOMER_ATTRS = ["utc_updated_at", "tax_exempt", "gender", "fax", "mobile", "status", "country", "street", "first_name", "company_name", "tin", "name", "membership_expired_at", "birthday", "zipcode", "last_name", "customer_type_id", "telephone", "remark", "code", "available_points", "utc_created_at", "city", "state", "email", "alternate_code"]
end

def prepare_data c4_json
    requests = []
    JSON.parse(c4_json).each do |e|
        cust = Hash.new
        entry = Hash.new
        CUSTOMER_ATTRS.each do |c|
            entry[c] = c4_json[c]
        end
        cust['customer'] = entry
        requests.push(cust.to_json)
    end
	return requests
end