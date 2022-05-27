class User
    require 'json'
    # role_code is read-only and returned an error while transferring
    USER_ATTRS = ["home_branch_id", "email", "role_id", "name", "is_locked"]
    def prepare_data c4_json
        requests = []
        JSON.parse(c4_json).each do |e|
            user = Hash.new
            entry = Hash.new
            USER_ATTRS.each do |u|
                entry[u] = e[u]
            end
            user['user'] = entry
            requests.push(user.to_json)
        end
        print requests
        return requests
    end
end