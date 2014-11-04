require 'net/http'
require 'json'
require 'addressable/uri'

require 'skyhook/core'
require 'skyhook/app'
require 'skyhook/player'

module Skyhook
  attr_accessor :format
  attr_accessor :key

  FORMATS = %W(json xml vdf).map { |x| x.to_sym.freeze }
  BASE = "api.steampowered.com".freeze

  def setup(options = {})
    FORMATS.include?(options[:format]) ? self.format = options[:format] : raise(ArgumentError,  "#{options[:format]} is not a valid format")
    self.key = key
  end

  def request(uri)
    response = Net::HTTP.get_response BASE, uri
    JSON.parse response.body
  end

  def service_interface(options = {})
    request("#{options[:api]}?key=#{@key}}&format=#{@format}&input_json=#{options[:json]}")
  end

  def resolve_vanity(vanityurl)
    vanityurl.is_a?(String) ? request("/ISteamUser/ResolveVanityURL/v0001/?key=#{key}&vanityurl=#{vanityurl}")["response"]["steamid"] : vanityurl
  end
end
