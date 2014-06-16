require "rubygems"
require "oauth"
require "json"

consumer = OAuth::Consumer.new(
        ENV['DESK_KEY'],
        ENV['DESK_SECRET'],
        :site => "https://redgrind.desk.com",
        :scheme => :header
)

access_token = OAuth::AccessToken.from_hash(
        consumer,
        :oauth_token => ENV['DESK_OAUTH_TOKEN'],
        :oauth_token_secret => ENV['DESK_OAUTH_TOKEN_SECRET']
)

#response = access_token.get("https://redgrind.desk.com/api/v2/cases?filter_id=2013094")
response = access_token.get("https://redgrind.desk.com/api/v2/cases/1")

puts JSON.parse(response.body).to_json