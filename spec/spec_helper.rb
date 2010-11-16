require 'action_view'
require 'minstrel'
require 'representative_view'
require 'rspec'

require 'fixtures/books'

module Fixtures
  
  def template_path
    File.join(File.dirname(__FILE__), "fixtures", "templates")
  end
  
end

Rspec.configure do |config|
  
  config.mock_with :rr
  config.include(Fixtures)
  
end

def undent(raw)
  if raw =~ /\A( +)/
    indent = $1
    raw.gsub(/^#{indent}/, '').gsub(/ +$/, '')
  else
    raw
  end
end
