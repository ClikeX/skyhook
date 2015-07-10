module Skyhook
  module Core::ISteamUserStats

    # ISteamUserStats
    # Methods relating to User stats.

    # TODO (ClikeX) Test this with multiple names.
    def global_stats( appid, count = 1, names = [], options = {} )
      parent.request "/ISteamUserStats/GetGlobalStatsForGame/v0001/?appidid=#{ appid }&count=#{}&name[0]=global.map.emp_isle"
    end

    def player_stats( appid, steamid )
      steamid = resolve_vanity steamid

      parent.request "/ISteamUserStats/GetUserStatsForGame/v2/?steamid=#{ steamid }&appid=#{ appid }"
    end

    def global_achievenement_percentages;end
    def number_of_current_players;end
    def player_achievements;end
    def schema_for_game;end

  end
end
