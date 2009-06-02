require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'model/init'

class Scraper
    def initialize
        @@user_agent = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.5) Gecko/2008121622 Ubuntu/8.10 (intrepid) Firefox/3.0.5 Ubiquity/0.1.4"
    end
    def init
        puts "Not implemented for this Scraper"
    end
    def update
        puts "Not implemented for this Scraper"
    end
    def parse(url)
        return Nokogiri::HTML.parse(open(url, "User-Agent" => @@user_agent))
    end
    def insert_tee(url,img,title,artist,source)
        Tee.create :url => url,
            :img => img,
            :title => title,
            :artist => artist,
            :source => source
    end
end
