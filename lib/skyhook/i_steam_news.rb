module Skyhook
  module Core::ISteamNews

    # SteamNews
    # Methods relating to Steam News.

    def self.news_for_app( appid, options = {} )
      maxlength = options[:maxlength]
      enddate = options[:enddate]
      count = options[:count]
      feeds = options[:feeds]

      response = parent.request '/ISteamNews/GetNewsForApp/v0002', appid: appid,  maxlength: maxlength, enddate: enddate, count: count, feeds: feeds
      response['appnews']
    end

  end
end
