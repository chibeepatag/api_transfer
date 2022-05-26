class Customer 
    require "json"
    
=begin
        #READ ONLY
        "utc_updated_at", "customer_type_id", "utc_created_at", "available_points", "code", "status", "membership_expired_at", "birthday", "gender"
=end
    CUSTOMER_ATTRS = [ "tax_exempt", "fax", "mobile", "country", "street", "first_name", "company_name", "tin", "name", "zipcode", "last_name", "telephone", "remark", "city", "state", "email", "alternate_code"]

    def prepare_data c4_json
        requests = []
        JSON.parse(c4_json).each do |e|
            cust = Hash.new
            entry = Hash.new
            CUSTOMER_ATTRS.each do |c|
                entry[c] = e[c]
                if e[c] == nil
                    entry[c] = nil
                end
            end
            cust['customer'] = entry
            requests.push(cust.to_json)
        end
        print requests
        return requests
    end

end

