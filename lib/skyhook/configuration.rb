module Skyhook
  class Configuration
    cattr_accessor :format
    cattr_accessor :api_key

    FORMATS = %W(json xml vdf).map { |x| x.to_sym.freeze }
    BASE = 'api.steampowered.com'

    def self.configure( options = {} )
      if options[ :format ]
        FORMATS.include?( options[ :format ] ) ? self.format = options[ :format ] : raise(ArgumentError,  "#{ options[ :format ] } is not a valid format" )
      else
        @@format = :json
      end
      @@api_key = options[:api_key] if options[:api_key]
    end
  end
end
