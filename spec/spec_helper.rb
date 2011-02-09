$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"..","lib"))
require "imap_tickler"
require "delorean"

RSpec.configure do |c|
  c.color_enabled = true
  c.mock_framework = :mocha
end

