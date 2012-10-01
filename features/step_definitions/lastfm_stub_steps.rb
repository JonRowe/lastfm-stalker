Given /^there is a last fm user "([^"]*)" currently listening to "([^"]*)" by "([^"]*)"$/ do |user, track, artist|
  json = <<-JSON
    {
      "recenttracks": {
        "track":
          [
            {"artist":{"#text":"#{artist}","mbid":""},"name":"#{track}","streamable":"0","mbid":"","album":{"#text":"Some Album","mbid":""},"url":"","image":[],"date":{"#text":"6 Feb 2011, 15:53","uts":"1297007635"}}
          ],
        "@attr": {"user":"#{user}","page":"1","perPage":"10","totalPages":"32625","total":"326248" }
      }
    }
  JSON
  uri = "http://ws.audioscrobbler.com/2.0"
  method = 'user.getrecenttracks'
  api_key = 'b25b959554ed76058ac220b7b2e0a026'
  stub_request(:get, uri)
    .with( :query => { :method => method, :user => user, :format => 'json', :api_key => api_key } )
    .to_return( :body => json, :status => 200, :headers => { "Content-type" => 'application/json' } )
end
