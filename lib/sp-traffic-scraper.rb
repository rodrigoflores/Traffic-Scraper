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
    end
  end
end

class CouldNotRetrievePageError < RuntimeError
end
