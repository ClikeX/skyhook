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
      response["response"]["steamid"]
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

    protected

    def request( uri )
      response = Net::HTTP.get_response BASE, uri
      JSON.parse response.body
    end

    def service_request( uri, options = {} )
      raise( ArgumentError,  'No JSON options were supplied' ) if options.empty?
      request "#{ uri }?key=#{ self.api_key }}&format=#{ self.format }&input_json=#{ options[:json]} "
    end
  end
end
