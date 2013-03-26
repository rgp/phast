require 'strscan'

module Phast
  module Scanner

    SEPARADORES = /\(|\)|\{|\}|\[|\]|:|\.|,|;/
    OPERADORES = /!=|!|\+|\*|\/|>|<|==|\|\||&&|=/


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

        when scanner.scan(/verbose[ ]*\{/) #Begin Verbose
          tokens << [:BLOCK_VERBOSE, "verbose"]
          vbose_level = [1]
            until vbose_level.empty?
                if scanner.empty?
                    STDERR.puts "Incomplete Verbose Block at #{scanner.rest} on line #{lineno}"
                    exit 1
                end

                case
                when scanner.scan(/\{/)
                    vbose_level.push 1
                when scanner.scan(/\}/)
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
        when match = scanner.scan(/int/)
          tokens << [:WORD_INT, match]
        when match = scanner.scan(/float/)
          tokens << [:WORD_FLOAT, match]
        when match = scanner.scan(/if/)
          tokens << [:WORD_IF, match]
        when match = scanner.scan(/else/)
          tokens << [:WORD_ELSE, match]
        when match = scanner.scan(/while/)
          tokens << [:WORD_WHILE, match]
        when match = scanner.scan(/for/)
          tokens << [:WORD_FOR, match]
        when match = scanner.scan(/class/)
          tokens << [:WORD_CLASS, match]
        when match = scanner.scan(/extends/)
          tokens << [:WORD_EXTENDS, match]
        when match = scanner.scan(/implements/)
          tokens << [:WORD_IMPLEMENTS, match]
        when match = scanner.scan(/do/)
          tokens << [:WORD_DO, match]
        when match = scanner.scan(/switch/)
          tokens << [:WORD_SWITCH, match]
        when match = scanner.scan(/case/)
          tokens << [:WORD_CASE, match]
        when match = scanner.scan(/break/)
          tokens << [:WORD_BREAK, match]
        when match = scanner.scan(/default/)
          tokens << [:WORD_DEFAULT, match]
        when match = scanner.scan(/continue/)
          tokens << [:WORD_CONTINUE, match]
        when match = scanner.scan(/fun/)
          tokens << [:WORD_FUN, match]
        when match = scanner.scan(/return/)
          tokens << [:WORD_RETURN, match]
        when match = scanner.scan(/static/)
          tokens << [:WORD_STATIC, match]
        when match = scanner.scan(/abstract/)
          tokens << [:WORD_ABSTRACT, match]
        when match = scanner.scan(/public/)
          tokens << [:WORD_PUBLIC, match]
        when match = scanner.scan(/private/)
          tokens << [:WORD_PRIVATE, match]
        when match = scanner.scan(/protected/)
          tokens << [:WORD_PROTECTED, match]
        when match = scanner.scan(/true|TRUE/)
          tokens << [:WORD_TRUE, match]
        when match = scanner.scan(/false|FALSE/)
          tokens << [:WORD_FALSE, match]
        when match = scanner.scan(/null|NULL/)
          tokens << [:WORD_NULL, match]
        when match = scanner.scan(/new/)
          tokens << [:WORD_NEW, match]
        when match = scanner.scan(/and/)
          tokens << [:WORD_AND, match]
        when match = scanner.scan(/or/)
          tokens << [:WORD_OR, match]
        when match = scanner.scan(/not/)
          tokens << [:WORD_NOT, match]
        when match = scanner.scan(/xor/)
          tokens << [:WORD_XOR, match]
        when match = scanner.scan(/try/)
          tokens << [:WORD_TRY, match]
        when match = scanner.scan(/catch/)
          tokens << [:WORD_CATCH, match]
        when match = scanner.scan(/throw/)
          tokens << [:WORD_THROW, match]
          
        #OPERATORS
        when match = scanner.scan(/===/)
          tokens << [:OP_IDENTICAL, match]
        when match = scanner.scan(/==/)
          tokens << [:OP_EQUAL, match]
        when match = scanner.scan(/!=/)
          tokens << [:OP_NOT_EQUAL, match]
        when match = scanner.scan(/=/)
          tokens << [:OP_ASIGN, match]
        when match = scanner.scan(/\+\+/)
          tokens << [:OP_INCREMENT, match]
        when match = scanner.scan(/--/)
          tokens << [:OP_DECREMENT, match]
        when match = scanner.scan(/\+/)
          tokens << [:OP_PLUS, match]
        when match = scanner.scan(/-/)
          tokens << [:OP_MINUS, match]
        when match = scanner.scan(/\*/)
          tokens << [:OP_MULTIPLY, match]
        when match = scanner.scan(/\//)
          tokens << [:OP_DIVIDE, match]
        when match = scanner.scan(/<=/)
          tokens << [:OP_LESS_EQUAL, match]
        when match = scanner.scan(/</)
          tokens << [:OP_LESS, match]
        when match = scanner.scan(/>=/)
          tokens << [:OP_GREATER_EQUAL, match]
        when match = scanner.scan(/>/)
          tokens << [:OP_EQUAL, match]

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
          STDERR.puts "Unkown input at #{scanner.rest}... on line #{lineno}"
          exit 1
        end
      end

      tokens
    end
  end
end
