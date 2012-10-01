require 'spec_helper'

module Lastfm::Stalker
  describe Client do

    describe "class attributes" do
      subject { Client }

      its(:base_uri) { should == "http://ws.audioscrobbler.com/2.0" }
    end

    its(:'class.ancestors') { should include HTTParty }
    its(:api_key) { should == 'b25b959554ed76058ac220b7b2e0a026' }

    describe "set_user" do
      let(:user) { "a_user" }

      subject { Client.new.tap { |c| c.set_user user } }

      its(:user) { should == user }
    end

    describe "fetch_current_track_for_user" do
      let(:user) { "a_user" }
      let(:client) { Client.new }
      let(:http_party_response) { mock "response" }
      let(:track_response) { mock "track response" }
      let(:track) { mock "track" }
      let(:parsed_response) { { "recenttracks" => { "track" => [track_response] } } }

      before do
        Client.stub(:get).and_return(http_party_response)
        http_party_response.stub(:parsed_response).and_return(parsed_response)
        Track.stub(:from_response).and_return(track)
      end

      subject { client.fetch_current_track_for user }

      it "should use HTTParty to get the most recent tracks for the user" do
        query = hash_including :format => 'json', :api_key => client.api_key, :method => 'user.getrecenttracks', :user => user
        Client.should_receive(:get).with(Client.base_uri,:query => query).and_return(http_party_response)
        subject
      end
      it "should get the parsed_response from the http_party_response" do
        http_party_response.should_receive(:parsed_response).and_return(parsed_response)
        subject
      end
      it "should parse the track" do
        Track.should_receive(:from_response).with(track_response).and_return(track)
        subject
      end
      it { should == track }
    end

    describe "now_playing" do
      let(:user)   { "a_user" }
      let(:client) { Client.new }
      let(:artist) { "The Band" }
      let(:name)   { "Song 2" }
      let(:track)  { mock "track", :artist => artist, :name => name }

      before do
        client.set_user user
        client.stub(:fetch_current_track_for).and_return(track)
      end

      subject { client.now_playing }

      it "should get the user you wish to stalk" do
        client.should_receive(:user).twice.and_return(user)
        subject
      end
      it "should get the current track for user" do
        client.should_receive(:fetch_current_track_for).with(user).and_return(track)
        subject
      end
      it "should get the track artist" do
        track.should_receive(:artist).and_return(artist)
        subject
      end
      it "should get the track name" do
        track.should_receive(:name).and_return(name)
        subject
      end
      it { should include user }
      it { should include artist }
      it { should include name }
    end

  end
end
