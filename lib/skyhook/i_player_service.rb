module Skyhook
  module Core::IPlayerService

    # IPlayerService
    # Methods relating to a Steam user's games.

    def self.owned_games( steamid, options = {} )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid
      appinfo = options[:appinfo].nil? ? false : options[:appinfo]
      free_games = options[:free_games].nil? ? false : options[:free_games]
      appids_filter = options[:appids_filter].nil? ? [] : options[:appids_filter]

      response = parent.request '/IPlayerService/GetOwnedGames/v1', steamid: steamid, include_appinfo: appinfo, include_played_free_games: free_games, appids_filter: appids_filter
      response['response']
    end

    def self.recently_played_games( steamid, count = 10 )
        steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid

        response = parent.request '/IPlayerService/GetRecentlyPlayedGames/v1', steamid: steamid, count: count
        response['response']
    end

    def self.steam_level( steamid )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid

      response = parent.request '/IPlayerService/GetSteamLevel/v1', steamid: steamid
      response['response']['player_level']
    end

    def self.badges( steamid )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid

      response = parent.request '/IPlayerService/GetBadges/v1', steamid: steamid
      response['response']
    end

    def self.community_badge_progress( steamid, badgeid = nil )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity steamid

      response = parent.request '/IPlayerService/GetCommunityBadgeProgress/v1', steamid: steamid, badgeid: badgeid
      response['response']['quests']
    end

  end
end
