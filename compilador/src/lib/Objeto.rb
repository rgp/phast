class Objeto

    attr_accessor :quads, :attributos, :papa, :nombre, :id

    def initialize(nombre,papa)
        @quads = []
        @attributos = {}
        @papa = papa
        @nombre = nombre
    end

end
