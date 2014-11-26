module Skyhook
  class User < Skyhook::Core

    attr_reader :steamid, :game, :response

    def initialize( steamid )
      @response = user_summaries steamid
    end

    # TODO Functionality

  end
end
