class Branch
    require 'json'
    # read-only
    # id, site_type, subscription_type, status, utc_created_at, utc_updated_at
    BRANCH_ATTRS = ["name", "state", "country", "city", "zipcode", "tin", "status", "street", "subscribed_at"] 
    def prepare_data c4_json
        requests = []
        JSON.parse(c4_json).each do |e|
            branch = Hash.new
            entry = Hash.new
            BRANCH_ATTRS.each do |b|
                entry[b] = e[b]
            end
            branch['branch'] = entry
            requests.push(branch.to_json)
        end
        print requests
        return requests
    end
end