require 'httparty'
require 'webmock/cucumber'
require 'aruba/cucumber'

Before do
  WebMock.disable_net_connect!
end
