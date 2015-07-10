module Skyhook
  module Core::IPlayerService

    # IPlayerService
    # Methods relating to a Steam user's games.

    def owned_games( steamid, options = {} )
      steamid = resolve_vanity steamid
      appinfo = options[:appinfo] == nil ? false : options[:appinfo]
      free_games = options[:free_games] == nil ? false : options[:free_games]

      parent.request "/IPlayerService/GetOwnedGames/v1/?steamid=#{ steamid }&include_appinfo='#{ appinfo }'&include_played_free_games='#{ free_games }'"
    end

    def self.recently_played_games;end
    def self.steam_level;end
    def self.badges;end
    def self.community_badge_progress;end

  end
end
