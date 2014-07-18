require 'spec_helper'

module Lastfm::Stalker
  describe CommandLine do
    let!(:client) { double "client" }
    let(:args) { ['--user','a_user'] }
    let(:now_playing) { 'a_user is listening to blahblah by the yackety yacks' }

    before do
      allow(Client).to receive(:new) { client }
      allow(client).to receive(:set_user)
      allow(client).to receive(:now_playing) { now_playing }
      allow($stdout).to receive(:puts)
    end

    subject { CommandLine::process args }

    it "should create a new client" do
      expect(Client).to receive(:new) { client }
      subject
    end
    it "should setup the user" do
      expect(client).to receive(:set_user).with('a_user')
      subject
    end
    it "should find out now playing" do
      expect(client).to receive(:now_playing) { now_playing }
      subject
    end
    it "should return nowplaying to stdout" do
      expect($stdout).to receive(:puts).with(now_playing)
      subject
    end
  end
end
