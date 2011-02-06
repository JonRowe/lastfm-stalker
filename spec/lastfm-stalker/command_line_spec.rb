require 'spec_helper'

module Lastfm::Stalker
  describe CmdLine do
    subject { CmdLine::process '--user a_user' }
  end
end
