require 'rubygems'
require 'bin/reader'

class Threadless < Scraper
    def init
        doc = parse 'bin/data_threadless.html'

        doc.css('div.product_container>div>a')[1..50].each do |link|
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
                insert_tee(url,img,title,artist,2)
                puts "#{url};#{img};#{title};#{artist}\n"
            end
        end
    end

    def update
        puts 'update'
    end
end

legal = ['init','update']
if ARGV.length > 0 && legal.include?(ARGV[0])
    obj = Threadless.new
    method = ARGV[0]
    obj.method(method).call()
else
    puts "No method called. Use: init,update"
end
