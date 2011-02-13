When "I run" do |command|
  # reset arguments to the ones we wish to supply
  ARGV.clear
  command.strip.split.each { |i| ARGV << i }
  executable = "./bin/#{ARGV.shift}"

  # simulate running command, we only do this to keep webmock stubs intact
  if File.executable? executable
    old_out = $stdout
    $stdout = StringIO.new

    load executable

    @output = $stdout
    $stdout = old_out
  else
    raise "Command not executable"
  end
end

Then "the output should contain:" do |string|
  @output.string.should include string
end
