require 'spec_helper'

describe Track do
  describe "from_response" do
    let(:artist) { "the band" }
    let(:track) { "the song" }
    let(:response) do
      {
         "artist" => { "#text" => artist },
         "name" => track
      }
    end

    let(:track_from_response) { Track.from_response response }

    specify { expect(track_from_response.artist).to eq artist }
    specify { expect(track_from_response.name).to eq track }
  end

  it { is_expected.to respond_to :artist }
  it { is_expected.to respond_to :name }
end
