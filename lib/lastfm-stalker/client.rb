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

      def fetch_current_track_for(user)
        response = Client.get self.class.base_uri, query(user: user, method: 'user.getrecenttracks')
        parsed_response = response.parsed_response
        Track.from_response parsed_response["recenttracks"]["track"].first
      end

      def now_playing
        track = fetch_current_track_for user
        "#{user} is currently listening to '#{track.name}' by '#{track.artist}'"
      end

      private
        def query(params)
          { query: { format: 'json', api_key: self.api_key }.merge(params) }
        end
    end
  end
end
