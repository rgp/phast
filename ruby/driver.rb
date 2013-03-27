require './rbs/scanner.rb'
require './rbs/parser.rb'

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

scanner = Phast::Scanner.new(str)
while (tk = scanner.next_token)
    puts tk.inspect
 # a = Phast::Parser.new(scanner)
 # a.parse(tokens)
end

