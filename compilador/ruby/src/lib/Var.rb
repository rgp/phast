class Var

    attr_accessor :nombre, :tipoDato, :valor, :direccion_virtual, :linea_definicion

    def initialize(nombre,tipoDato,valor,direccion_virtual,linea_definicion)
        @nombre = nombre
        @tipoDato = tipoDato
        @valor = valor
        @direccion_virtual = direccion_virtual
        @linea_definicion = linea_definicion
    end

    def definida_en?
        @linea_definicion
    end

    def to_s
        if($debug)
            "[#{@nombre},#{@valor}]"
        else
            if @valor != nil
                "#{-@direccion_virtual}"
            else
                "#{@direccion_virtual}"
            end
        end
    end
end
