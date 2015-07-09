module Skyhook
  class Core < Skyhook::Configuration

    def api_reference
      url = '/ISteamWebAPIUtil/GetSupportedAPIList/v0001/'

      unless @api_key.blank?
        url << "?key=#{ self.api_key }"
      end

      request url
    end

    def server_at_address( ip_address )
      url = "/ISteamApps/GetServersAtAddress/v1?addr=#{ ip_address }&format=#{self.format}"
      unless @api_key.blank?
        url << "&key=#{ self.api_key }"
      end

      request url
    end

    def up_to_date_check( appid, version )
      request "/ISteamApps/UpToDateCheck/v1?key=#{ self.api_key }&appid=#{ appid }&version=#{ version }"
    end

    def app_list
      request '/ISteamApps/GetAppList/v2'
    end

    def resolve_vanity( vanityurl )
      response = request "/ISteamUser/ResolveVanityURL/v0001/?key=#{ self.api_key }&vanityurl=#{ vanityurl }"
      if response["response"]["message"]
        vanityurl.to_i
      else
        response["response"]["steamid"].to_i
      end
    end

    def user_summaries( steamids = [] )
      steamids = [ steamids ] unless steamids.is_a? Array

      if steamids.empty?
        p 'No steamids were defined'
        return nil
      end

      steamids.map! do |steamid|
        steamid = resolve_vanity steamid
      end

      request "/ISteamUser/GetPlayerSummaries/v0002/?key=#{ self.api_key }&steamids=#{ steamids }"
    end

    def player_stats( appid, steamid )
      steamid = resolve_vanity steamid

      request "/ISteamUserStats/GetUserStatsForGame/v2/?key=#{self.api_key }&steamid=#{ steamid }&appid=#{ appid }"
    end

    # TODO (ClikeX) Test this with multiple names.
    def global_stats( appid, count = 1, names = [], options = {} )
      request "/ISteamUserStats/GetGlobalStatsForGame/v0001/?appidid=#{ appid }&count=#{}&name[0]=global.map.emp_isle"
    end

    def owned_games( steamid, options = {} )
      steamid = resolve_vanity steamid
      appinfo = options[:appinfo] == nil ? false : options[:appinfo]
      free_games = options[:free_games] == nil ? false : options[:free_games]

      request "/IPlayerService/GetOwnedGames/v1/?key=#{ self.api_key }&steamid=#{ steamid }&include_appinfo='#{ appinfo }'&include_played_free_games='#{ free_games }'"
    end

    def friend_list( steamid, relationship )
      steamid = resolve_vanity steamid
      raise( ArgumentError,  'Not a valid relationship' ) unless %w{ all friend }.include? relationship

      request "/ISteamUser/GetFriendList/v1/?key=#{ self.api_key }&steamid=#{ steamid }&relationship=#{ relationship }"
    end

    protected

    def request( uri )
      JSON.parse connection.get( uri ).body
    end

    def service_request( uri, options = {} )
      raise( ArgumentError,  'No JSON options were supplied' ) if options.empty?
      request "#{ uri }?key=#{ self.api_key }}&format=#{ self.format }&input_json=#{ options[:json]} "
    end
  end
end
