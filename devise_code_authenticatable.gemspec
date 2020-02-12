$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "devise_code_authenticatable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "devise_code_authenticatable"
  spec.version     = DeviseCodeAuthenticatable::VERSION
  spec.authors     = ["vincentying15"]
  spec.email       = ["vincent_ying_live@outlook.com"]
  spec.summary     = "devise_code_authenticatable"
  spec.description = "Devise plugin to allow sign in by email sent code"
  spec.license     = "MIT"
  spec.homepage    = "https://rubygems.org/gems/devise_code_authenticatable"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["source_code_uri"] = "https://github.com/vincentying15/devise_code_authenticatable"


  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"

end
