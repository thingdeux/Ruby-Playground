require 'json'
require "open-uri"

module Twitch
  class TwitchFactory

    def initialize()
      @twitch_api_base_url = "https://api.twitch.tv/kraken/"
      @twitch_api_key = "blah"
    end

    def get_top_games
      final_hash = {}
      raw_response = URI.parse(@twitch_api_base_url.concat('games/top/')).read
      response = JSON.parse(raw_response)
      final_hash["total"] = response["_total"]
      get_top_game_counts(response["top"], final_hash)
    end

    def get_top_game_counts(top_json_object, passed_hash)
      # Expects a json parsed twitch top json object with the following structure
      # Returns a hash of game names to counts ... ex: {"Starcraft"=>12354}
      # "top": [
      #     {
      #     "game": {
      #     "name": "Counter-Strike: Global Offensive",
      #     "box": {
      #     "large": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-272x380.jpg",
      #     "medium": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-136x190.jpg",
      #     "small": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-52x72.jpg",
      #     "template": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
      #     },
      #     "logo": {
      #     "large": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-240x144.jpg",
      #     "medium": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-120x72.jpg",
      #     "small": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-60x36.jpg",
      #     "template": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
      #     },
      #     "_links": {},
      #     "_id": 32399,
      #     "giantbomb_id": 36113
      #     },
      #     "viewers": 23873,
      #     "channels": 305
      # },
      # More Details found here: https://github.com/justintv/Twitch-API/blob/master/v3_resources/games.md
      if top_json_object.is_a?(Array)
        top_json_object.each do |twitch_game_object|
          viewers = twitch_game_object["viewers"]
          game_name = twitch_game_object["game"]["name"] || ""
          if game_name.length > 0
            passed_hash[game_name] = viewers
          end
        end
      end
      passed_hash
    end

    private :get_top_game_counts

  end
end