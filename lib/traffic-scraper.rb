require 'open-uri'
require 'nokogiri'
require "traffic-scraper/version"

module Traffic
  class Scraper
    class << self
      TRAFFIC_PAGE_URL = "http://www.cetsp.com.br/"

      # Returns the amount of overall traffic we currently have
      #
      # @return [Integer] the amount of traffic
      def overall_traffic
        zone_traffic.values.inject(:+)
      rescue
        raise CouldNotRetrievePageError
      end

      # Returns the amount of overall traffic we currently have
      #
      # @return [Hash] containing all the traffic information for all zones
      def zone_traffic
        page = Nokogiri::HTML(open(TRAFFIC_PAGE_URL))

        result_hash = {}

        { "norte" => :north ,
          "sul" => :south,
          "leste" => :east,
          "oeste" => :west,
          "centro" => :downtown
        }.each do |zone, zone_translation|
          match = /^(\d+)\s*km$/.match(page.css(".info.#{zone} h4").inner_html)

          raise CouldNotRetrievePageError unless match
          result_hash[zone_translation] = match[1].to_i
        end

        result_hash
      rescue
        raise CouldNotRetrievePageError
      end
    end
  end
end

class CouldNotRetrievePageError < RuntimeError
end
