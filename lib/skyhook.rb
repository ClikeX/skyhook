require 'active_support/all'
require 'net/http'

require 'skyhook/configuration'
require 'skyhook/core'
require 'skyhook/game'
require 'skyhook/user'

module Skyhook
  def self.configure( options = {} )
    self::Configuration.configure options
  end
end
