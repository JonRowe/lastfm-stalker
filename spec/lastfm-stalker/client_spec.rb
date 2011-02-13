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

    describe "now_playing" do
      let(:user) { "a_user" }
      let(:client) { Client.new }

      before do
        client.set_user user
      end

      subject { client.now_playing }

      it "should get the user you wish to stalk" do
        client.should_receive(:user).and_return(user)
        subject
      end
      it "should use HTTParty to get the most recent tracks for the user" do
        query = hash_including format: 'json', api_key: client.api_key, method: 'user.getrecenttracks', user: user
        Client.should_receive(:get).with(Client.base_uri,query: query)
        subject
      end
    end

  end
end
