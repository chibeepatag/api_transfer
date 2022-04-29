module ApplicationHelper
    # URL for POST Request
    def postRequestURLc3(api_url, data_type)
        return "#{api_url}/api/#{data_type.downcase}.json"
    end

    # URL for GET Request
    def getRequestURLc4(data_type, page_num)
        return "https://c4.imonggo.com/api/#{data_type.downcase}.json?page=#{page_num}"
    end

    # This function counts the number of active entries given a page_count query
    def numPages(num_entries)
        return (num_entries % 50 == 0) ? (num_entries / 50) : ((num_entries / 50) + 1)
    end

    #Deals with Products API Only
    def processPostReq(req_url, apiToken, res)
        reqs = []
        entry = Hash.new
        # Note that tax_rates, utc_created_at, status, minimum_quantity, maximum_quantity are READ-ONLY
        # barcode_array attribute is only found on C3 Accounts!
        trans = ["disable_discount", "cost", "allow_decimal_quantities", "tag_list", "retail_price", "name", "tax_exempt", "barcode_list", "disable_inventory", "stock_no", "enable_open_price", "description"]
        response = JSON.parse(res)
        response.each do |e|
            prod = Hash.new
            trans.each do |t|
                entry[t] = e[t]
            end
            prod['product'] = entry
            req = processRequest req_url, apiToken, "post", prod.to_json
            reqs.push(req)
        end
        return reqs
    end
    
    
    # This function only deals with Products API and HTTP GET/POST requests
    def processRequest(request_url, apiToken, reqType="get", data=nil)
        #Handles URL Requests
        uri = URI(request_url)

        if reqType == 'get'
            req = Net::HTTP::Get.new(uri)
        else    
            req = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json'})
            req.body = data
        end

        #API Token Handling
        req.basic_auth apiToken, "password"

        # Handles HTTP Requests
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(req)
        end 

        return res.body
    end
end
