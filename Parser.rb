require 'API/itunes'
require 'API/twitch'

class Parser
  include Twitch
  include ITunes


  def initialize()
    @twitch_factory = new Twitch.Factory
    @itunes_factory = new ITunes.Factory
  end

  def get_latest_twitch_feeds()
    @twitch_factory.get_top_games
  end
end