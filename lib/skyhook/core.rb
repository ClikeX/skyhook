module Skyhook
  class Core < Skyhook::Configuration

    RESTAPI = {
      owned_games: "",
      shared_games: ""
    }.freeze

    # TODO Recreate request methods
    # TODO Put more code in the REST API

    protected
    def request(uri)
      response = Net::HTTP.get_response BASE, uri
      JSON.parse response.body
    end

    def service_request(uri, options = {})
      raise(ArgumentError,  'No JSON options were supplied') if options.empty?
      request("#{uri}?key=#{self.key}}&format=#{self.format}&input_json=#{options[:json]}")
    end
  end
end
