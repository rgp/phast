require './src/scanner.rb'
require './src/parser.rb'

file = File.new("test/comments.ph", "r")
str = ""
while (line = file.gets)
    str << line
end
file.close

tokens = Phast::Scanner.scan(str)
puts "TOKENS:\n"
puts tokens
# puts "PARSE:\n"
# a = Phast::Parser.new
# a.parse(tokens)

