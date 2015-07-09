module Skyhook
  class Configuration
    cattr_accessor :format
    cattr_accessor :api_key
    cattr_accessor :debug

    FORMATS = %W(json xml vdf).map { |x| x.to_sym.freeze }
    BASE = 'api.steampowered.com'

    def self.configure( options = {} )
      if options[ :format ]
        FORMATS.include?( options[ :format ] ) ? self.format = options[ :format ] : raise(ArgumentError,  "#{ options[ :format ] } is not a valid format" )
      else
        @@format = :json
      end
      @@api_key = options[:api_key] if options[:api_key]
      @@debug = options[:debug] if options[:debug]
    end

    def connection
      Faraday.new(:url => 'http://api.steampowered.com') { |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        }
    end

  end
end
