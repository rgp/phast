class Var

    attr_accessor :nombre, :tipo, :scope, :direccion

    def initialize(nombre,tipo,direccion,scope,line_at)
        @nombre = nombre
        @tipo = tipo
        @direccion = direccion
        @scope = scope
        @declared_at = line_at
    end

    def declared_at
        @declared_at
    end

    def to_s
        $debug ? @nombre : @direccion
    end
end
