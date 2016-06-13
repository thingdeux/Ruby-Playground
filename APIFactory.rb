require_relative 'API/itunes'
require_relative 'API/twitch'

class ApiFactory
  include Twitch
  include ITunes

  def initialize()
    @twitch_factory = TwitchFactory.new
    @itunes_factory = ITunesFactory.new
  end

  def get_latest_twitch_feeds()
    @twitch_factory.get_top_games
  end
end