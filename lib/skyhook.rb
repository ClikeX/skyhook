require 'active_support/all'
require 'faraday'

require 'skyhook/configuration'
require 'skyhook/core'
require 'skyhook/game'
require 'skyhook/user'
require 'skyhook/i_player_service'
require 'skyhook/i_steam_apps'
require 'skyhook/i_steam_economy'
require 'skyhook/i_steam_news'
require 'skyhook/i_steam_user'
require 'skyhook/i_steam_user_stats'



module Skyhook

  Faraday::Utils.default_params_encoder = Faraday::FlatParamsEncoder

  def self.configure( options = {} )
    self::Configuration.configure options
  end
end
