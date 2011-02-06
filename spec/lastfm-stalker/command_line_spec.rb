require 'spec_helper'

module Lastfm::Stalker
  describe CommandLine do
    let!(:client) { mock "client" }
    let(:args) { ['--user','a_user'] }
    let(:now_playing) { 'a_user is listening to blahblah by the yackety yacks' }

    before do
      Client.stub(:new).and_return client
      client.stub(:set_user)
      client.stub(:now_playing).and_return now_playing
    end

    subject { CommandLine::process args }

    it "should create a new client" do
      Client.should_receive(:new).and_return client
      subject
    end
    it "should setup the user" do
      client.should_receive(:set_user).with('a_user')
      subject
    end
    it "should find out now playing" do
      client.should_receive(:now_playing).and_return(now_playing)
      subject
    end
    it "should return nowplaying to stdout" do
      $stdout.should_receive(:puts).with(now_playing)
      subject
    end
  end
end
