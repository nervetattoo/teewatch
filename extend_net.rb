require 'rubygems'
require 'net/http'
module Net
    def self.final_url?(url,limit=5,orig=nil)
        response = Net::HTTP.get_response(URI.parse(url))
        case response
            when Net::HTTPSuccess then url == orig
            when Net::HTTPRedirection then 
                begin
                    final_url(response['location'], limit - 1,url)
                rescue RuntimeError => err
                    raise
                end
        else
            response.error!
        end
    end

    # Return final url in a redirection chain
    def self.final_url(url,limit=5,orig=nil)
        response = Net::HTTP.get_response(URI.parse(url))
        if limit == 0
            raise RuntimeError, "Too much recursing in uri lookup",caller
        end
        case response
            when Net::HTTPNotFound then response.error!
            when Net::HTTPSuccess then url
            when Net::HTTPRedirection then final_url(response['location'], limit - 1,url)
        else
            response.error!
        end
    end

    # Test if two urls are on the same domain
    def self.same_domain?(u1,u2)
        r = /http:\/\/(www\.)?([a-z0-9]*)\.com/
        return r.match(u1)[2].to_s == r.match(u2)[2].to_s
    end
end

'''
#Examples:
u1 = "http://threadless.com/gorba"
u2 = "http://typetees.com/gorba"
u3 = "http://typetees.com/gorba"
u4 = "http://www.threadless.com/product/1819/Face"

puts Net::same_domain? u1,u2
puts Net::same_domain? u3,u2
puts Net::same_domain? u1,u4
begin
    puts Net::final_url u1
rescue RuntimeError => exception
    puts "#{u1} is buggered somehow"
end
'''
