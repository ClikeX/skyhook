module Skyhook
  class Core

    def self.app_list()
      request('/ISteamApps/GetAppList/v0001/')
    end

    def self.news_for_app(appid, count, maxlength)
      request("/ISteamNews/GetNewsForApp/v0002/?appid=#{appid}&count=#{count}&maxlength=#{maxlength}&format=#{format}")
    end

    def self.global_achievements(appid)
      request("/ISteamUserStats/GetGlobalAchievementPercentagesForApp/v0002/?gameid='#{appid}'&format=#{format}")
    end

    # FIXME: This has been broken since forver. Will be fixed later
    self.def self.global_stats(appid, count)
      request("/ISteamUserStats/GetGlobalStatsForGame/v0001/?format=#{format}&appid=#{appid}'&count='#{count}/name[0]=global.map.emp_isle")
    end

    # User requests

    def self.player_friendlist(steamid, relation)
      steamid = resolve_vanity(steamid)
      request "/ISteamUser/GetFriendList/v0001/?key=#{key}&steamid=#{steamid}&relationship=#{relation}"
    end

    def self.player_stats(appid, steamid)
      steamid = resolve_vanity(steamid)
      request "/ISteamUserStats/GetUserStatsForGame/v0002/?appid=#{appid}&key=#{key}&steamid=#{steamid}"
    end

    def self.player_sums(steamid)
      steamid = resolve_vanity(steamid)
      request "/ISteamUser/GetPlayerSummaries/v0002/?key=#{key}&steamids=#{steamid}&format=#{format}"
    end

    def self.player_achievements(appid, steamid)
      steamid = resolve_vanity(steamid)
      request "/ISteamUserStats/GetPlayerAchievements/v0001/?appid=+ #{appid}&key=#{key}&steamid=#{steamid}"
    end

    def self.player_owned(steamid)
      steamid = resolve_vanity(steamid)
      request "/IPlayerService/GetOwnedGames/v0001/?key=#{key}&steamid=#{steamid}&format=#{format}"
    end

    def self.player_recent(steamid)
      steamid = resolve_vanity(steamid)
      request "/IPlayerService/GetRecentlyPlayedGames/v0001/?key=#{key}&steamid=#{steamid}&format=#{format}"
    end

    def self.playing_shared(appid, steamid)
      steamid = resolve_vanity(steamid)
      request "/IPlayerService/IsPlayingSharedGame/v0001/?key=#{key}&steamid=#{steamid}&appid_playing=#{appid}&format=#{format}"
    end
  end
end
