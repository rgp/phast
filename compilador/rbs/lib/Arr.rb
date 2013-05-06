class ArrDefinition
    #id -> Var
    #length -> int
    #initQuads -> Quads []
    attr_accessor :id, :length, :initQuads

    def initialize(id)
        @id = id
        @length = 0
        @initQuads = []
    end
end
