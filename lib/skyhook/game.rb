module Skyhook
  class Game < Skyhook::Core

    attr_reader :appid

    def initialize( appid, steamid = nil )
      super
      self.appid = appid
      self.steamid = steamid
    end

    def stats ( args = {} )
      steamid = args[:user] || args[:steamid]

      super.player_stats(self.appid, steamid)
    end

  end
end
