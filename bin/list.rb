$:.unshift(
    File.join(File.dirname(__FILE__), '..'),
    File.dirname(__FILE__)
)
require 'rubygems'
require 'model/init'

class List
    def sources(limit)
        Source.all.each do |r|
            puts "[#{r.id}] - #{r.title}"
        end
    end
    def tees(limit)
        Tee.all.each do |r|
            puts "[#{r.id}] - #{r.title} (#{r.url})"
        end
    end
end

legal = ['sources','tees']
if ARGV.length > 0 && legal.include?(ARGV[0])
    limit = '25'
    if ARGV[1]
        limit = ARGV[1]
    end
    obj = List.new
    method = ARGV[0]
    obj.method(method).call(limit)
else
    puts "No method called. Use: sources or tees"
end
