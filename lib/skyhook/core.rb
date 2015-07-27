module Skyhook
  class Core < Skyhook::Configuration

    def self.api_reference
      request '/ISteamWebAPIUtil/GetSupportedAPIList/v1/'
    end

    def self.get_method(method_name)
      api_reference['apilist']['interfaces'].each do |interface|

        if meth = interface['methods'].find { |method|method['name'] == method_name }
          meth['interface'] = interface['name']
          return meth
        else
          nil
        end
      end
    end

    def self.method_missing(m, params = {})
      if method = get_method( m.to_s.camelize )
        url = "/#{ method['interface'] }/#{ method['name'] }/v#{ method['version'] }/"

        self.class.class_eval do
          define_method m do |params|
            request( "#{url}", params )
          end
        end

        send(m, params)
      else
        super
      end
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
