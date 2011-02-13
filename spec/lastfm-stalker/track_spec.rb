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

    subject { Track.from_response response }

    its(:artist) { should == artist }
    its(:name) { should == track }
  end

  it { should respond_to :artist }
  it { should respond_to :name }
end
