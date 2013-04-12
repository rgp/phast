require_relative 'rbs/scanner.rb'
require_relative 'rbs/parser.rb'

if ARGV[0].empty?
    puts "Sin archivo de entrada"
    exit 1
end

if(ARGV.include? "-d")
    $debug = true
    ARGV.delete "-d"
else
    $debug = false
end

#Leemos el archivo de entrada
file = File.new(ARGV.first, "r")
str = ""
while (line = file.gets)
    str << line
end
file.close

parser = Phast::Parser.new(Phast::Scanner.new(str))
parser.parse
