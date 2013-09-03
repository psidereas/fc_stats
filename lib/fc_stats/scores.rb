require 'httparty'

module FcStats
  class Scores
    SOURCE_URL = "http://espnfc.com/results/_/league/eng.1/english-premier-league?cc=5901"
    def self.get_scores
      @scores ||= HTTParty.get(SOURCE_URL).parsed_response
    end
  end
end
