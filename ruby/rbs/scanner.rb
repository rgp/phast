require 'strscan'

module Phast
  class Scanner

    SEPARADORES = /\(|\)|\{|\}|\[|\]|:|\.|,|;/
    OPERADORES = /!=|!|\+|\*|\/|>|<|==|\|\||&&|=/


    def initialize(source)
        @src = source
        @scanner = StringScanner.new source
        $lineno = 1
    end

    def rest
        @scanner.rest
    end
    
    def next_token
        token = []
        if @scanner.empty?
            return nil
        end
        until !token.empty?
            case

            when @scanner.scan(/\n/) #Count line breaks
                $lineno += 1
            when @scanner.scan(/\s+/) #Eats tabs and white spaces
            when @scanner.scan(/\/\/.*\n/)
                $lineno += 1
            when @scanner.scan(/\/\*/) #Begin Comment Block
                until @scanner.scan(/\*\//)
                    if @scanner.empty?
                        STDERR.puts "Incomplete Comment Block at #{@scanner.rest}"
                        exit 1
                    end
                    case
                    when @scanner.scan(/\n/)
                        $lineno += 1
                    when @scanner.scan(/\s+/)
                    when @scanner.scan(/./)
                    else
                    end
                end

            when @scanner.scan(/verbose[ ]*\{/) #Begin Verbose
                token = [:BLOCK_VERBOSE, "verbose"]
                vbose_level = [1]
                until vbose_level.empty?
                    if @scanner.empty?
                        STDERR.puts "Incomplete Verbose Block at #{@scanner.rest} on line #{$lineno}"
                        exit 1
                    end

                    case
                    when @scanner.scan(/\{/)
                        vbose_level.push 1
                    when @scanner.scan(/\}/)
                        vbose_level.pop
                    when @scanner.scan(/\n/)
                        $lineno += 1
                    when @scanner.scan(/\s+/)
                    when @scanner.scan(/./)
                    else
                    end
                end

                #PH TAGS
            when @scanner.scan(/<\?/)
                token = [:PH_OT, "<?"]
            when @scanner.scan(/\?>/)
                token = [:PH_CT, "?>"]

                #KEYWORDS
            when match = @scanner.scan(/int/)
                token = [:WORD_INT, match]
            when match = @scanner.scan(/float/)
                token = [:WORD_FLOAT, match]
            when match = @scanner.scan(/if/)
                token = [:WORD_IF, match]
            when match = @scanner.scan(/else/)
                token = [:WORD_ELSE, match]
            when match = @scanner.scan(/while/)
                token = [:WORD_WHILE, match]
            when match = @scanner.scan(/for/)
                token = [:WORD_FOR, match]
            when match = @scanner.scan(/class/)
                token = [:WORD_CLASS, match]
            when match = @scanner.scan(/extends/)
                token = [:WORD_EXTENDS, match]
            when match = @scanner.scan(/implements/)
                token = [:WORD_IMPLEMENTS, match]
            when match = @scanner.scan(/do/)
                token = [:WORD_DO, match]
            when match = @scanner.scan(/switch/)
                token = [:WORD_SWITCH, match]
            when match = @scanner.scan(/case/)
                token = [:WORD_CASE, match]
            when match = @scanner.scan(/break/)
                token = [:WORD_BREAK, match]
            when match = @scanner.scan(/default/)
                token = [:WORD_DEFAULT, match]
            when match = @scanner.scan(/continue/)
                token = [:WORD_CONTINUE, match]
            when match = @scanner.scan(/fun/)
                token = [:WORD_FUN, match]
            when match = @scanner.scan(/return/)
                token = [:WORD_RETURN, match]
            when match = @scanner.scan(/static/)
                token = [:WORD_STATIC, match]
            when match = @scanner.scan(/abstract/)
                token = [:WORD_ABSTRACT, match]
            when match = @scanner.scan(/public/)
                token = [:WORD_PUBLIC, match]
            when match = @scanner.scan(/private/)
                token = [:WORD_PRIVATE, match]
            when match = @scanner.scan(/protected/)
                token = [:WORD_PROTECTED, match]
            when match = @scanner.scan(/true|TRUE/)
                token = [:WORD_TRUE, match]
            when match = @scanner.scan(/false|FALSE/)
                token = [:WORD_FALSE, match]
            when match = @scanner.scan(/null|NULL/)
                token = [:WORD_NULL, match]
            when match = @scanner.scan(/new/)
                token = [:WORD_NEW, match]
            when match = @scanner.scan(/and/)
                token = [:WORD_AND, match]
            when match = @scanner.scan(/or/)
                token = [:WORD_OR, match]
            when match = @scanner.scan(/not/)
                token = [:WORD_NOT, match]
            when match = @scanner.scan(/xor/)
                token = [:WORD_XOR, match]
            when match = @scanner.scan(/try/)
                token = [:WORD_TRY, match]
            when match = @scanner.scan(/catch/)
                token = [:WORD_CATCH, match]
            when match = @scanner.scan(/throw/)
                token = [:WORD_THROW, match]

                #OPERATORS
            when match = @scanner.scan(/===/)
                token = [:OP_IDENTICAL, match]
            when match = @scanner.scan(/==/)
                token = [:OP_EQUAL, match]
            when match = @scanner.scan(/!=/)
                token = [:OP_NOT_EQUAL, match]
            when match = @scanner.scan(/=/)
                token = [:OP_ASIGN, match]
            when match = @scanner.scan(/\+\+/)
                token = [:OP_INCREMENT, match]
            when match = @scanner.scan(/--/)
                token = [:OP_DECREMENT, match]
            when match = @scanner.scan(/\+/)
                token = [:OP_PLUS, match]
            when match = @scanner.scan(/-/)
                token = [:OP_MINUS, match]
            when match = @scanner.scan(/\*/)
                token = [:OP_MULTIPLY, match]
            when match = @scanner.scan(/\//)
                token = [:OP_DIVIDE, match]
            when match = @scanner.scan(/<=/)
                token = [:OP_LESS_EQUAL, match]
            when match = @scanner.scan(/</)
                token = [:OP_LESS, match]
            when match = @scanner.scan(/>=/)
                token = [:OP_GREATER_EQUAL, match]
            when match = @scanner.scan(/>/)
                token = [:OP_EQUAL, match]

                #REGEX
            when match = @scanner.scan(/[a-zA-Z_][a-zA-Z0-9_]*/)
                token = [:ID, match]
            when match = @scanner.scan(/\d+\.\d+(e(\+|-)?\d+)?/)
                token = [:FLOAT, match]
            when match = @scanner.scan(/\d+/)
                token = [:INT, match]
            when match = @scanner.scan(/"(\\.|[^"])*"/)
                token = [:STRING, match[1..-2]]

            when match = @scanner.scan(SEPARADORES)
                token = [match, match]

            when match = @scanner.scan(OPERADORES)
                token = [match, match]
            when @scanner.eos?
                return nil
            else
                STDERR.puts "Unkown input at #{@scanner.rest}... on line #{$lineno}"
                exit 1
            end
        end
        token
    end
  end
end
