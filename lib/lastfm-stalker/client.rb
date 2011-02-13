module Lastfm
  module Stalker
    class Client
      include HTTParty

      attr_reader :user

      base_uri "http://ws.audioscrobbler.com/2.0"

      def api_key
        'b25b959554ed76058ac220b7b2e0a026'
      end

      def set_user(value)
        @user = value
      end

      def now_playing
        query = { user: user, format: 'json', api_key: self.api_key, method: 'user.getrecenttracks' }
        Client.get self.class.base_uri, query: query
      end
    end
  end
end
