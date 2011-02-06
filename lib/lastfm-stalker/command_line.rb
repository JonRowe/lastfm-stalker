module Lastfm
  module Stalker
    class CommandLine
      def self.process(args)
        client = Client.new
        client.set_user args[1]
        $stdout.puts client.now_playing
      end
    end
  end
end
