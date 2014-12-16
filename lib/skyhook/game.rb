module Skyhook
  class Game < Skyhook::Core

    attr_reader :appid, :user, :game_name, :achievements, :stats

    def initialize( appid, steamid = nil )
      @appid = appid
      if steamid == nil
        # If steamid is not set a game should contain global data
      else
        if steamid.is_a? Skyhook::User
          @user = steamid
        else
          @user = Skyhook::User.new steamid
        end

        set_user_attributes player_stats( appid, user.steamid )['playerstats']
      end
    end

    def set_user_attributes( response )
      @game_name = response['gameName']
      @achievements = ( Hash[ response['achievements'].each_slice(2).to_a ] ).deep_symbolize_keys if response['achievements']
      @stats = ( Hash[ response['stats'].each_slice(2).to_a ] ).deep_symbolize_keys if response['stats']
    end

    def set_global_attributes( response )
      #Will return a games global stats
    end

  end
end
