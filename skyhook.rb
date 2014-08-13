require 'net/http'
require 'json'
require 'addressable/uri'

module Skyhook
  attr_accessor :format
  attr_accessor :key

  FORMATS = %W(json xml vdf).map { |x| x.to_sym.freeze  }
  BASE = "api.steampowered.com"

  def setup(key ,format = :json)
    if FORMATS.include?(format) then
      @format = format
    else
      raise(ArgumentError,  "#{format} is not a valid format")
    end
    @key = key
  end

  def app_list()
    request('/ISteamApps/GetAppList/v0001/')
  end

  def news_for_app(appid, count, maxlength)
    request("/ISteamNews/GetNewsForApp/v0002/?appid=#{appid}&count=#{count}&maxlength=#{maxlength}&format=#{format}")
  end

  def global_achievements(appid)
    request("/ISteamUserStats/GetGlobalAchievementPercentagesForApp/v0002/?gameid='#{appid}'&format=#{format}")
  end

  # FIXME: This has been broken since forver. Will be fixed later
  def global_stats(appid, count)
    request("/ISteamUserStats/GetGlobalStatsForGame/v0001/?format=#{format}&appid=#{appid}'&count='#{count}/name[0]=global.map.emp_isle")
  end

  def player_friendlist(steamid, relation)
    request("/ISteamUser/GetFriendList/v0001/?key=#{key}&steamid=#{steamid}&relationship=#{relation}")
  end

  def player_stats(appid, steamid)
    if steamid.is_a?(String) then
      steamid = resolve_vanity(steamid)
    end

    request("/ISteamUserStats/GetUserStatsForGame/v0002/?appid=#{appid}&key=#{key}&steamid=#{steamid}")
  end

  def player_sums(steamid)
    request("/ISteamUser/GetPlayerSummaries/v0002/?key=#{key}&steamids=#{steamid}&format=#{format}")
  end

  def player_achievements(appid, steamid)
    request("/ISteamUserStats/GetPlayerAchievements/v0001/?appid=+ #{appid}&key=#{key}&steamid=#{steamid}")
  end

  def player_owned(steamid)
    request("/IPlayerService/GetOwnedGames/v0001/?key=#{key}&steamid=#{steamid}&format=#{format}")
  end

  def player_recent(steamid)
    request("/IPlayerService/GetRecentlyPlayedGames/v0001/?key=#{key}&steamid=#{steamid}&format=#{format}")
  end

  def resolve_vanity(vanityurl)
    request("/ISteamUser/ResolveVanityURL/v0001/?key=#{key}&vanityurl=#{vanityurl}")["response"]["steamid"]
  end

  def playing_shared(appid, steamid)
    request("/IPlayerService/IsPlayingSharedGame/v0001/?key=#{key}&steamid=#{steamid}&appid_playing=#{appid}&format=#{format}")
  end

  def service_interface(api,json)
    request("#{api}?key=#{key}&format=#{format}&input_json=#{json}")
  end

  private
  def request(uri)
    response = Net::HTTP.get_response(BASE, uri)
    JSON.parse(response.body)
  end
end

if $0 == __FILE__
  class SteamApp
    include Skyhook

    def initialize(key="")
      setup(key)
    end

  end

  app = SteamApp.new

  puts app.player_stats(550,"ClikeX" )

end
