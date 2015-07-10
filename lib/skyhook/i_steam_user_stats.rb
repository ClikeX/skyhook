module Skyhook
  module Core::ISteamUserStats

    # ISteamUserStats
    # Methods relating to User stats.

    def self.player_stats( appid, steamid )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid

      response = parent.request '/ISteamUserStats/GetUserStatsForGame/v2', steamid: steamid, appid: appid
      response['playerstats']
    end

    def self.player_achievements( appid, steamid, options = {} )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid
      l = options[:l] || options[:language]

      response = parent.request '/ISteamUserStats/GetPlayerAchievements/v1', appid: appid, steamid: steamid, l: l
      response['playerstats']
    end

    def self.number_of_current_players( appid )
      response = parent.request '/ISteamUserStats/GetNumberOfCurrentPlayers/v1', appid: appid
      response['response']['player_count']
    end

    # FIXME(ClikeX) this won't work without names. But names do use the [] url parameter encoding. This won't work with faraday
    def self.global_stats( appid, count = 1, options = {} )
      startdate = options[:startdate]
      enddate = options[:enddate]

      parent.request '/ISteamUserStats/GetGlobalStatsForGame/v0001', appidid: appid, count: count, startdate: startdate, enddate: enddate
    end

    def self.global_achievenement_percentages( appid )

      response = parent.request '/ISteamUserStats/GetGlobalAchievementPercentagesForApp/v0002', gameid: appid
      response['achievementpercentages']['achievements']
    end

    def self.schema_for_game(appid, options = {})
      l = options[:l] || options[:language]

      result = parent.request '/ISteamUserStats/GetSchemaForGame/v2', appid: appid, l: l
      result['game']
    end
  end
end
