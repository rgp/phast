require_relative 'Instrucciones.rb'

class Quad

    attr_accessor :instruccion, :op1, :op2, :registro

    def initialize(instruccion,op1,op2,registro)
        @instruccion = instruccion
        @op1 = op1
        @op2 = op2
        @registro = registro
    end

    def saltos i
        case @instruccion 
        when Phast::GOTO
        when Phast::GOTOF
        when Phast::GOTOV
        when Phast::CALL
            @registro += i if @registro.is_a? Integer
        end
    end
    
    def to_s
        if($debug)
            #Convierte a texto
            @instruccion = Phast.i_to_s(@instruccion) if (@instruccion.is_a? Integer) 
        end
            "#{@instruccion}\t#{@op1.to_s}\t#{@op2.to_s}\t#{@registro}"
    end
end
