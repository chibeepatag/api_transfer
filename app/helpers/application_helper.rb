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
