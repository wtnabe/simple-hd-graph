$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "simple-hd-graph"

require "minitest/autorun"
require "minitest/reporters"
require "minitest-power_assert"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

Dir.glob(__dir__ + "/support/**/*.rb").select { |f|
  f !~ /_(spec|test)\.rb/
}.each { |f|
  require f
}
