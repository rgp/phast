module Phast

    GOTO = 1
    GOTOF = 2
    GOTOV = 3
    CALL = 4
    SUM = 5
    MUL = 6
    DIV = 7
    REST = 8
    AND = 9
    OR = 10
    ASIG = 11
    GT = 12
    LT = 13
    EGT = 14
    ELT = 15
    EQ = 16
    RET = 17
    PRT = 18
    PAR = 19
    ARG = 20
    REV = 21
    PRTLN = 22

    def self.i_to_s(i)
        case
        when i == GOTO
            "Goto"
        when i == GOTOF
            "GotoF"
        when i == GOTOV
            "GotoV"
        when i == CALL
            "Call"
        end
    end

    def self.op_to_inst(op)
        case
        when op == "+"
            SUM
        when op == "-"
            REST
        when op == "*"
            MUL
        when op == "/"
            DIV
        when op == "and"
            AND
        when op == "or"
            OR
        when op == ">"
            GT
        when op == "<"
            LT
        when op == "<="
            ELT
        when op == ">="
            EGT
        when op == "="
            ASIG
        when op == "=="
            EQ
        end
    end


    def self.op_to_s(o)
        puts "Not yet implemented"
    end
end
