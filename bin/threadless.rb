$:.unshift(
    File.join(File.dirname(__FILE__), '..'),
    File.dirname(__FILE__)
)
require 'rubygems'
require 'reader'

class Threadless < Scraper
    def init
        doc = parse 'http://www.threadless.com/catalog/type,guys'

        doc.css('div.product_container>div>a').each do |link|
            # Dont include Typetees and Select
            if link['href'] =~ /http/
                next
            end
            url = 'http://www.threadless.com' + link['href']
            img = link.css("img").first["src"]
            # Get title and other stuff
            product = parse url
            title = nil
            artist = nil
            product.css("div.page_head").each do |head|
                title = head.css("span.blue").first.content
                artist = head.css("span a").first.content
                if insert_tee(url,img,title,artist,2)
                    puts "#{url};#{img};#{title};#{artist}\n"
                end
                    puts "#{url};#{title} all ready exists\n"
            end
        end
    end

    def update
        puts 'update'
    end
end

Threadless.run ARGV
