module Skyhook
  module Core::ISteamRemoteStorage

    # ISteamRemoteStorage
    # Methods relating to stored files.

    # TODO finish implementing this

    def collection_details;end
    def published_file_details;end

    def ugcf_file_details( ugcid, appid, options = {} )
      steamid = Skyhook::Core::ISteamUser.resolve_vanity options[:steamid] unless options.empty?

      response = parent.request 'ISteamRemoteStorage/GetUGCFileDetails/v1/', ugcid: ugcid, appid: appid, steamid: steamid
      if response['status']['code'] == 9
        raise StandardError
      else
        response['data']
      end
    end

  end
end
