require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList["spec/**/*_spec.rb"]
end

YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb"]
  t.options = ["--any", "--extra", "--opts"]
end

task :default => :spec
