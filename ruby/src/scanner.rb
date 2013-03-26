require 'strscan'

module Phast
  module Scanner

    SEPARADORES = /\(|\)|\{|\}|\[|\]|:|\.|,|;/
    OPERADORES = /!=|!|\+|-|\*|\/|>|<|==|\|\||&&|=/


    def self.scan(source)
      tokens = []
      scanner = StringScanner.new source
      lineno = 0

      until scanner.empty?
        case

        when scanner.scan(/\n/)
            lineno += 1
          #Counts lines
        when scanner.scan(/\s+/)
          #Eats tabs and white spaces
        when scanner.scan(/\/\/.*\n/)
            lineno += 1
        
        when scanner.scan(/\/\*/) #Begin Comment Block
            until scanner.scan(/\*\//)
                if scanner.empty?
                    STDERR.puts "Incomplete Comment Block at #{scanner.rest}"
                    exit 1
                end

                case
                when scanner.scan(/\n/)
                    lineno += 1
                when scanner.scan(/\s+/)
                when scanner.scan(/./)
                else
                end
            end

        when scanner.scan(/verbose[ ]*{/) #Begin Verbose
          tokens << [:BLOCK_VERBOSE, "verbose"]
          vbose_level = [1]
            until vbose_level.empty?
                if scanner.empty?
                    STDERR.puts "Incomplete Verbose Block at #{scanner.rest}"
                    exit 1
                end

                case
                when scanner.scan(/{/)
                    vbose_level.push 1
                when scanner.scan(/}/)
                    vbose_level.pop
                when scanner.scan(/\n/)
                    lineno += 1
                when scanner.scan(/\s+/)
                when scanner.scan(/./)
                else
                end
            end

        #PH TAGS
        when scanner.scan(/<\?/)
          tokens << [:PH_OT, "<?"]
        when scanner.scan(/\?>/)
          tokens << [:PH_CT, "?>"]
        #KEYWORDS
        when scanner.scan(/import\b/)
          tokens << [:KEY_IMPORT, "import"]
        when match = scanner.scan(/func main\b/)
          tokens << [:KEY_MAIN, match]
        when match = scanner.scan(/func\b/)
          tokens << [:KEY_FUNC, match]
        when match = scanner.scan(/struct\b/)
          tokens << [:KEY_STRUCT, match]
        when match = scanner.scan(/for\b/)
          tokens << [:KEY_FOR, match]
        when match = scanner.scan(/while\b/)
          tokens << [:KEY_WHILE, match]
        when match = scanner.scan(/if\b/)
          tokens << [:KEY_IF, match]
        when match = scanner.scan(/else\b/)
          tokens << [:KEY_ELSE, match]
        when match = scanner.scan(/int\b/)
          tokens << [:KEY_INT, match]
        when match = scanner.scan(/float\b/)
          tokens << [:KEY_FLOAT, match]
        when match = scanner.scan(/string\b/)
          tokens << [:KEY_STRING, match]
        when match = scanner.scan(/boolean\b/)
          tokens << [:KEY_BOOLEAN, match]
        when match = scanner.scan(/print\b/)
          tokens << [:KEY_PRINT, match]
        when match = scanner.scan(/true\b/)
          tokens << [:KEY_TRUE, match]
        when match = scanner.scan(/false\b/)
          tokens << [:KEY_FALSE, match]
        when match = scanner.scan(/return\b/)
          tokens << [:KEY_RETURN, match]
        when match = scanner.scan(/break\b/)
          tokens << [:KEY_BREAK, match]
        when match = scanner.scan(/thread_is_dead\b/)
          tokens << [:KEY_THREAD_IS_DEAD, match]
        when match = scanner.scan(/thread_is_alive\b/)
          tokens << [:KEY_THREAD_IS_ALIVE, match]
        when match = scanner.scan(/thread_run\b/)
          tokens << [:KEY_THREAD_RUN, match]
        when match = scanner.scan(/join\b/)
          tokens << [:KEY_JOIN, match]
        when match = scanner.scan(/return\b/)
          tokens << [:KEY_RETURN, match]
        when match = scanner.scan(/var\b/)
          tokens << [:KEY_VAR, match]

        #REGEX
        when match = scanner.scan(/[a-zA-Z_][a-zA-Z0-9_]*/)
          tokens << [:ID, match]
        when match = scanner.scan(/\d+\.\d+(e(\+|-)?\d+)?/)
          tokens << [:FLOAT, match]
        when match = scanner.scan(/\d+/)
          tokens << [:INT, match]
        when match = scanner.scan(/"(\\.|[^"])*"/)
          tokens << [:STRING, match[1..-2]]

        when match = scanner.scan(SEPARADORES)
          tokens << [match, match]

        when match = scanner.scan(OPERADORES)
          tokens << [match, match]
        else
          STDERR.puts "Unkown input at #{scanner.rest}..."
          exit 1
        end
      end

        puts "LOC: #{lineno}"
      tokens
    end
  end
end
