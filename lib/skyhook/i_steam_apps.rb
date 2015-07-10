module Skyhook
  module Core::ISteamApps

    # ISteamApps
    # Methods relating to Steam Apps in general.

    def self.server_at_address( ip_address )
      parent.request "/ISteamApps/GetServersAtAddress/v1?addr=#{ ip_address }&format=#{self.format}"
    end

    def self.up_to_date_check( appid, version )
      parent.request "/ISteamApps/UpToDateCheck/v1?appid=#{ appid }&version=#{ version }"
    end

    def self.app_list
      parent.request '/ISteamApps/GetAppList/v2'
    end

  end
end
