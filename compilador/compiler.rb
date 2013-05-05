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

out = "bin.pho"
if(ARGV.include? "-o")
    o = ARGV.index("-o") + 1
    out = ARGV[o]
    ARGV.delete "-o"
    ARGV.delete out
end

ARGV.delete "--"

# Por lo pronto solo funciona con el primer archivo de entrada
#
#Leemos el archivo de entrada
file = File.new(ARGV.first, "r")
str = ""
while (line = file.gets)
    str << line
end
file.close

parser = Phast::Parser.new(Phast::Scanner.new(str),out)
parser.parse
