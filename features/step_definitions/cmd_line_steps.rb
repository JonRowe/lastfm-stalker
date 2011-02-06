When /^I run$/ do |command|
  run_simple unescape command
end

Then /^the output should contain$/ do |output|
  assert_partial_output(output)
end
