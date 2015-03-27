module Skyhook
  class Game < Skyhook::Core

    attr_reader :appid, :user, :game_name, :achievements, :stats

    def initialize( appid, steamid = nil )
      @appid = appid
      if steamid == nil
        # If steamid is not set a game should contain global data
        set_global_attributes
      else
        if steamid.is_a? Skyhook::User
          @user = steamid
        else
          @user = Skyhook::User.new steamid
        end

        set_user_attributes player_stats( appid, @user.steamid )['playerstats']
      end
    end

    def set_user_attributes( response )
      @game_name = response['gameName']

      @achievements = response['achievements']
      @stats = response['stats']

    end

    def set_global_attributes
      #Will return a games global stats
      raise NotImplementedError
    end

  end
end
