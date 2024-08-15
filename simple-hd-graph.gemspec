lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple-hd-graph/version"

Gem::Specification.new do |spec|
  spec.name = "simple-hd-graph"
  spec.version = SimpleHdGraph::VERSION
  spec.authors = ["wtnabe"]
  spec.email = ["18510+wtnabe@users.noreply.github.com"]

  spec.summary = "single-tier hierary and simplex direction graph DSL"
  spec.description = "parse single-tier hierarchy and simplex direction graph from YAML, and generate PlantUML with rectangle and object"
  spec.homepage = "https://github.com/wtnabe/simple-hd-graph"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.metadata["source_code_uri"] + "/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "dry-inflector", "~> 0"
end
