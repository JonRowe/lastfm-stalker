When /^I run$/ do |command|
  # reset arguments to the ones we wish to supply
  ARGV.clear
  command.strip.split.each { |i| ARGV << i }
  executable = "./bin/#{ARGV.shift}"

  # simulate running command, we only do this to keep webmock stubs intact
  if File.executable? executable
    load executable
  else
    raise "Command not executable"
  end
end
