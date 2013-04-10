module Phast

    GOTO = 1
    GOTOF = 2
    GOTOV = 3

    def self.i_to_s(i)
        case
        when i == GOTO
            "Goto"
        when i == GOTOF
            "GotoF"
        when i == GOTOV
            "GotoV"
        end
    end
    def self.op_to_s(o)
        puts "Not yet implemented"
    end
end
