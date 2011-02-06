require 'spec_helper'

module Lastfm::Stalker
  describe Client do
    describe "set_user" do
      let(:user) { "a_user" }

      subject { Client.new.tap { |c| c.set_user user } }

      its(:user) { should == user }
    end
  end
end
