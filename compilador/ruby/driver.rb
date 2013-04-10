require_relative 'rbs/scanner.rb'
require_relative 'rbs/parser.rb'

if ARGV[0].empty?
    puts "Sin archivo de entrada"
    exit 1
end

#Leemos el archivo de entrada
file = File.new(ARGV[0], "r")
str = ""
while (line = file.gets)
    str << line
end
file.close

parser = Phast::Parser.new(Phast::Scanner.new(str))
parser.parse
