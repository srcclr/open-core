$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "discourse_reports/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "discourse_reports"
  s.version     = DiscourseReports::VERSION
  s.homepage    = "https://srcclr.com"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rake"
  s.add_dependency "sitemap_generator", "5.1.0"
end
