$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootstrap_builders/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootstrap_builders"
  s.version     = BootstrapBuilders::VERSION
  s.authors     = ["kaspernj"]
  s.email       = ["kaspernj@gmail.com"]
  s.homepage    = "https://github.com/kaspernj/bootstrap_builders"
  s.summary     = "A library to generate Bootstrap HTML for Rails."
  s.description = "A library to generate Bootstrap HTML for Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "html_gen", ">= 0.0.13"

  s.add_development_dependency "devise", "3.5.6"
  s.add_development_dependency "sqlite3", "1.3.11"
  s.add_development_dependency "cancancan", "1.13.1"

  # Test suite
  s.add_development_dependency "rspec-rails", "3.4.2"
  s.add_development_dependency "factory_girl_rails", "4.6.0"
  s.add_development_dependency "haml", ">= 4.0.7"
  s.add_development_dependency "spring", "1.6.4"
  s.add_development_dependency "simple_form", "3.3.1"
  s.add_development_dependency "capybara", "2.6.2"
  s.add_development_dependency "capybara-webkit", "1.8.0"

  # Run development commands faster
  s.add_development_dependency "spring-commands-rspec", "1.0.4"
  s.add_development_dependency "spring-commands-rubocop", "0.1.0"

  # Linters
  s.add_development_dependency "best_practice_project", "0.0.9"
  s.add_development_dependency "rubocop", "0.40.0"
end
