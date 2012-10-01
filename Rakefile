require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

desc "Run specs"
RSpec::Core::RakeTask.new :spec

desc "Run integrations"
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end
task :default => [:spec, :features]
