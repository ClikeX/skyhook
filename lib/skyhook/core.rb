module Skyhook
  class Core < Skyhook::Configuration

    # These are default urls to use with #Service_request
    RESTAPI = {
      owned_games: "",
      shared_games: ""
    }.freeze

    def api_reference
      url = "/ISteamWebAPIUtil/GetSupportedAPIList/v0001/"

      unless @api_key.blank?
        url << "?key=#{ self.api_key }"
      end

      request url
    end

    def resolve_vanity( vanityurl )
      return vanityurl if vanityurl.is_a? Integer
      response = request "/ISteamUser/ResolveVanityURL/v0001/?key=#{ self.api_key }&vanityurl=#{ vanityurl }"
      response["response"]["steamid"].to_i
    end

    def user_summaries( steamids = [] )
      steamids = [ steamids ] unless steamids.is_a? Array

      if steamids.empty?
        p 'No steamids were defined'
        return false
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

    protected

    def request( uri )
      puts "#{BASE}#{uri}" if self.debug
      response = Net::HTTP.get_response BASE, uri
      JSON.parse response.body
    end

    def service_request( uri, options = {} )
      raise( ArgumentError,  'No JSON options were supplied' ) if options.empty?
      request "#{ uri }?key=#{ self.api_key }}&format=#{ self.format }&input_json=#{ options[:json]} "
    end
  end
end
