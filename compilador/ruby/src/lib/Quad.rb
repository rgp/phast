require_relative 'Instrucciones.rb'
class Quad

    attr_accessor :instruccion, :op1, :op2, :registro

    def initialize(instruccion,op1,op2,registro)
        @instruccion = instruccion
        @op1 = op1
        @op2 = op2
        @registro = registro
    end

    def to_s
        if($debug)
            #Convierte a texto
            @instruccion = Phast.i_to_s(@instruccion) if (@instruccion.is_a? Integer) 
        end
            "#{@instruccion}\t#{@op1}\t#{@op2}\t#{@registro}"
    end
end