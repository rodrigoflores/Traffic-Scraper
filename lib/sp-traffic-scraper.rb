require 'open-uri'
require 'nokogiri'
require "sp-traffic-scraper/version"

module Traffic
  class Scraper
    class << self
      TRAFFIC_PAGE_URL = "http://cetsp1.cetsp.com.br/monitransmapa/agora/"

      def overall_traffic
        page = Nokogiri::HTML(open(TRAFFIC_PAGE_URL))
        page.css("#lentidao b").inner_html.to_i
      rescue
        raise CouldNotRetrievePageError
      end

      def zone_traffic
        page = Nokogiri::HTML(open(TRAFFIC_PAGE_URL))

        result_hash = {}

        { "Norte" => :north ,
          "Sul" => :south,
          "Leste" => :east,
          "Oeste" => :west,
          "Centro" => :downtown
        }.each do |zone, zone_translation|
          page.css("##{zone}Lentidao").inner_html =~ /^(\d+)\s*km$/

          result_hash[zone_translation] = $1.to_i
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
