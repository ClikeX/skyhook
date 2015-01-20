module Skyhook
  class User < Skyhook::Core

    attr_reader :steamid, :personaname, :realname, :profileurl
    attr_reader :avatar, :avatarmedium, :avatarfull
    attr_reader :communityvisibilitystate, :profilestate, :lastlogoff, :commentpermission
    attr_reader :primaryclanid, :timecreated, :personastateflags, :personastate
    attr_reader :loccityid, :locstatecode, :loccountrycode

    def initialize( steamid )
      set_attributes user_summaries( steamid )["response"]["players"][0]
    end

    def game( appid )
      Skyhook::Game.new appid, self
    end

    def friends( relationship = :friend )
      @friends ||= friend_list @steamid, relationship
    end

    private

    def set_attributes( response )
      @steamid = response["steamid"].to_i
      @personaname = response["personaname"]
      @communityvisibilitystate = response["communityvisibilitystate"]
      @profilestate = response["profilestate"]
      @lastlogoff = response["lastlogoff"]
      @commentpermission = response["commentpermission"]
      @profileurl = response["profileurl"]
      @avatar = response["avatar"]
      @avatarmedium = response["avatarmedium"]
      @avatarfull = response["avatarfull"]
      @personastate = response["personastate"]
      @realname = response["realname"]
      @primaryclanid = response["primaryclanid"]
      @timecreated = response["timecreated"]
      @personastateflags = response["personastateflags"]
      @loccountrycode = response["loccountrycode"]
      @locstatecode = response["locstatecode"]
      @loccityid = response["loccityid"]
    end

  end
end
