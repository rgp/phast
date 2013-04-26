class Scope

    attr_accessor :quads, :variables, :temporales, :papa, :registro

    def initialize(papa)
        @quads = []
        @variables = {}
        @temporales = []
        @papa = papa
        @registro = 0
    end

end
