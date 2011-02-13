class Track
  attr_accessor :artist, :name

  def self.from_response(response)
    new.tap do |track|
      track.artist = response["artist"]["#text"]
      track.name = response["name"]
    end
  end
end
