module Skyhook
  class User < Skyhook::Core

    attr_reader :steamid, :game

    def initialize( steamid )
      self.steamid = steamid
    end

    # TODO Functionality

  end
end
