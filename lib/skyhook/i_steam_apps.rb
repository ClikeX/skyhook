module Skyhook
  module Core::ISteamApps

    # ISteamApps
    # Methods relating to Steam Apps in general.

    def self.server_at_address( ip_address )
      response = parent.request '/ISteamApps/GetServersAtAddress/v1', addr: ip_address
      response['response']['servers']
    end

    def self.up_to_date_check( appid, version )
      response = parent.request '/ISteamApps/UpToDateCheck/v1', appid: appid, version: version
      response
    end

    def self.app_list
      response = parent.request '/ISteamApps/GetAppList/v2'
      response['applist']['apps']
    end

  end
end
