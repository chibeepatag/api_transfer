module ApplicationHelper
    # URL for POST Request
    def postRequestURLc3(api_url, data_type)
        return "#{api_url}/api/#{data_type.downcase}.json"
    end

    # URL for GET Request
    def getRequestURLc4(data_type, page_num)
        return "https://c4.imonggo.com/api/#{data_type.downcase}.json?active_only=1&page=#{page_num}"
    end

    # This function counts the number of active entries given a page_count query
    def numPages(num_entries)
        return (num_entries % 50 == 0) ? (num_entries / 50) : ((num_entries / 50) + 1)
    end

    # Post Request Handler given Data Type
    def jsonEntry(data_type, entry)
        if data_type == 'products'
            puts "ENTITY: #{@entity}"
            return @entity.prepare_data(entry)
        end
    end

    #Creates and Posts Entries with All Data Types given C4 GET Response
    def processPostReq(req_url, apiToken, data_type, res)
        reqs = []
        JSON.parse(res).each do |e|
            prod = jsonEntry(data_type, e)
            puts "Product..."
            req = processRequest req_url, apiToken, "post", prod.to_json
            reqs.push(req)
        end
        return reqs
    end
    
    
    # This function deals with HTTP GET/POST requests
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
