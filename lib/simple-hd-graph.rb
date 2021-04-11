module SimpleHdGraph
  class Error < StandardError; end
  # Your code goes here...
end

Dir.glob(__dir__ + '/simple-hd-graph/**/*.rb').each { |f|
  require_relative f.sub(/\.rb\z/, '')
}
