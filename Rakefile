require 'bundler'
require "rake/testtask"
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--color"
  t.verbose = false
end
 
task :default => [:test, :spec]
