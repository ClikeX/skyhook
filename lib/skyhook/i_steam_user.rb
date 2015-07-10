module Skyhook
  module Core::ISteamUser

    # ISteamUser
    # Methods relating to Steam users.

    def self.friend_list( steamid, relationship )
      steamid = resolve_vanity steamid
      raise( ArgumentError,  'Not a valid relationship' ) unless %w{ all friend }.include? relationship

      response = parent.request '/ISteamUser/GetFriendList/v1', steamid: steamid, relationship: relationship
      response['friendslist']['friends']
    end

    def self.resolve_vanity( vanityurl )
      response = parent.request '/ISteamUser/ResolveVanityURL/v0001', vanityurl: vanityurl

      if response["response"]["message"]
        vanityurl.to_i
      else
        response["response"]["steamid"].to_i
      end
    end

    def self.resolve_vanities( *vanityurls )
      vanityurls.map! do |vanityurl|
        resolve_vanity vanityurl
      end
    end

    def self.user_summaries( *steamids )
      steamids = resolve_vanities steamids

      response = parent.request '/ISteamUser/GetPlayerSummaries/v0002', steamids: steamids
      response["response"]["players"]
    end

    def self.player_bans( *steamids )
      steamids = resolve_vanities steamids

      response = parent.request '/ISteamUser/GetPlayerBans/v1', steamids: steamids
      response["players"]
    end

    def self.user_group_list( steamid )
      steamid = resolve_vanity steamid
      response = parent.request '/ISteamUser/GetUserGroupList/v1', steamid: steamid
      response["response"]["groups"]
    end

  end
end
