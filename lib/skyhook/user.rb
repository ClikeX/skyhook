module Skyhook
  class User < Skyhook::Core

    attr_reader :steamid, :game

    def initialize( steamid )
      @steamid = steamid
    end

    # TODO Functionality

  end
end
