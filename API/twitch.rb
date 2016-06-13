require 'json'
require "net/http"
require "uri"

module Twitch
  class Factory
    def initialize()
      @twitch_api_base_url = "https://api.twitch.tv/kraken/"
      @twitch_api_key = "blah"
    end

    def get_top_games
      top_url = @twitch_api_base_url.join('games/top/')
      response = JSON.parse('{"josh": 1}')
      total_count = response["_total"]
    end

    def get_top_game_counts(top_json_object)
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
        hash_to_return = {}
        top_json_object.each do |twitch_game_object|
          viewers = twitch_game_object["viewers"]
          # TODO: Exception here if key is missing? -- test
          game_name = twitch_game_object["game"]["name"]
          unless game_name.nil? {
            hash_to_return[game_name] = viewers
          }
          end

        end
      end

    end

    private :get_top_game_counts




  end
end