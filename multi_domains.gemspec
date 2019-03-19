$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multi_domains/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multi_domains"
  s.version     = MultiDomains::VERSION
  s.authors     = ["Berlimioz"]
  s.email       = ["berlimioz@gmail.com"]
  s.homepage    = "https://github.com/Berlimioz/multi_domains.git"
  s.summary     = "A simple gem to handle multiple domains on the same application."
  s.description = "A simple gem to handle multiple domains on the same application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 5.2.2"

  s.add_development_dependency "sqlite3"
end
