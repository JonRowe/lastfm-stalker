require 'spec_helper'

module Lastfm::Stalker
  describe Client do

    describe "class attributes" do
      specify { expect(Client.base_uri).to eq "http://ws.audioscrobbler.com/2.0" }
    end

    specify { expect(Client.new.api_key).to eq 'b25b959554ed76058ac220b7b2e0a026' }

    describe "set_user" do
      let(:user) { "a_user" }

      let(:client) { Client.new.tap { |c| c.set_user user } }

      specify { expect(client.user).to eq user }
    end

    describe "fetch_current_track_for_user" do
      let(:user) { "a_user" }
      let(:client) { Client.new }
      let(:http_party_response) { double "response" }
      let(:track_response) { double "track response" }
      let(:track) { double "track" }
      let(:parsed_response) { { "recenttracks" => { "track" => [track_response] } } }

      before do
        allow(Client).to receive(:get) { http_party_response }
        allow(http_party_response).to receive(:parsed_response) { parsed_response }
        allow(Track).to receive(:from_response) { track }
      end

      subject { client.fetch_current_track_for user }

      it "should use HTTParty to get the most recent tracks for the user" do
        query = hash_including :format => 'json', :api_key => client.api_key, :method => 'user.getrecenttracks', :user => user
        expect(Client).to receive(:get).with(Client.base_uri,:query => query) { http_party_response }
        subject
      end
      it "should get the parsed_response from the http_party_response" do
        expect(http_party_response).to receive(:parsed_response) { parsed_response }
        subject
      end
      it "should parse the track" do
        expect(Track).to receive(:from_response).with(track_response) { track }
        subject
      end
      it { is_expected.to eq track }
    end

    describe "now_playing" do
      let(:user)   { "a_user" }
      let(:client) { Client.new }
      let(:artist) { "The Band" }
      let(:name)   { "Song 2" }
      let(:track)  { double "track", :artist => artist, :name => name }

      before do
        client.set_user user
        allow(client).to receive(:fetch_current_track_for) { track }
      end

      subject { client.now_playing }

      it "should get the user you wish to stalk" do
        expect(client).to receive(:user).twice { user }
        subject
      end
      it "should get the current track for user" do
        expect(client).to receive(:fetch_current_track_for).with(user) { track }
        subject
      end
      it "should get the track artist" do
        expect(track).to receive(:artist) { artist }
        subject
      end
      it "should get the track name" do
        expect(track).to receive(:name) { name }
        subject
      end
      it { is_expected.to include user }
      it { is_expected.to include artist }
      it { is_expected.to include name }
    end

  end
end
