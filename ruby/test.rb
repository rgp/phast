require './rbs/scanner.rb'
require './rbs/parser.rb'

if ARGV[0].empty?
    puts "Sin archivo de entrada"
    exit 1
end

file = File.new(ARGV[0], "r")
str = ""
while (line = file.gets)
    str << line
end
file.close

tokens = Phast::Scanner.scan(str)
 a = Phast::Parser.new
 a.parse(tokens)

