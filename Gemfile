source "http://rubygems.org"

# Specify your gem's dependencies in representative_view.gemspec
gemspec

if ENV["ACTIONPACK_VERSION"]
  gem "actionpack", ENV["ACTIONPACK_VERSION"]
end

group :test do
  gem "rake"
  gem "rspec", "~> 2.0.1"
  gem "rr", "~> 1.0.0"
  gem "minstrel"
end
