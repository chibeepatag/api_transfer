module ApplicationHelper
    # Request URL Handlers 
    def requestURLc3(api_url, data_type, page_num)
        return "#{api_url}/api/#{data_type}.json?page=#{page_num}"
    end

    def requestURLc4(data_type, page_num)
        return "https://c4.imonggo.com/api/#{data_type}.json?page=#{page_num}"
    end

    # This function counts the number of active entries given a page_count query
    def numPages(num_entries)
        return (num_entries % 50 == 0) ? (num_entries / 50) : ((num_entries / 50) + 1)
    end

    # This function only deals with HTTP GET requests
    def processRequest(request_url, apiToken)
        #Handles URL Requests
        uri = URI(request_url)
        req = Net::HTTP::Get.new(uri)

        #API Token Handling
        req.basic_auth apiToken, "password"

        # Handles HTTP Requests
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(req)
        end 
        
        return res.body
    end
end
