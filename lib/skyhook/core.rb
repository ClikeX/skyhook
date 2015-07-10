module Skyhook
  class Core < Skyhook::Configuration

    def self.api_reference
      request '/ISteamWebAPIUtil/GetSupportedAPIList/v0001/'
    end

    def self.server_info
      request '/ISteamWebAPIUtil/GetServerInfo/v0001/'
    end

    protected

    def self.request( uri, params = {} )
      # uri << "&key=#{ self.api_key }" if self.api_key
      conn = Faraday.new(:url => 'http://api.steampowered.com') do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

      response = conn.get do |req|
        req.url uri

        req.params['key'] = self.api_key if self.api_key

        params.each do |param, value|
          value = (value.is_a? TrueClass) ? "'true'" : value
          value = (value.is_a? FalseClass) ? "'false'" : value

          req.params[param] = value
        end unless params.empty?
      end

      JSON.parse response.body

    end

    def service_request( uri, options = {} )
      raise( ArgumentError,  'No JSON options were supplied' ) if options.empty?
      request "#{ uri }?key=#{ self.api_key }}&format=#{ self.format }&input_json=#{ options[:json]} "
    end
  end
end
