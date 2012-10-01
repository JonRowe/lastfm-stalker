require 'httparty'
require 'webmock/cucumber'

Before do
  WebMock.disable_net_connect!
end
