require 'addressable/uri'
require 'rest-client'

# bin/my_script.rb
def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.patch(
    url,
    { user: { name: "Buster" } }
  )
end

begin
  create_user
rescue RestClient::Exception => e
  puts e.message
end
