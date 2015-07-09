require 'active_support/all'
require 'faraday'

require 'skyhook/configuration'
require 'skyhook/core'
require 'skyhook/game'
require 'skyhook/user'

module Skyhook
  def self.configure( options = {} )
    self::Configuration.configure options
  end
end
