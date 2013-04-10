class Var

    attr_accessor :nombre, :tipo, :scope, :direccion, :valor

    @@dir = {}
    # -2 constantes
    # -1 temporal
    # 0 global
    # 1 scope 1
    # ...
    # n scope n
    @@mem_for_scopes = 0
    @@mem_for_ctes = 0
    @@mem_for_temp = 0
    @@mem_for_global = 0

    def initialize(nombre,tipo,valor,scope,line_at)
        @nombre = nombre
        @tipo = tipo
        @scope = scope
        @declared_at = line_at
        @valor = valor

        if @@dir[scope] == nil
            @@dir[scope] = 1
        else
            @@dir[scope] += 1
        end

        @direccion = @@dir[scope]
         # tmp = @direccion
         # @direccion = "#{scope}_#{tmp}"
    end

    def declared_at
        @declared_at
    end

    def to_s
        if($debug)
            @nombre
        else
            "#{@direccion + @@dir[@scope]}"
        end
    end

    def self.map_mem
        scope_dirs = @@dir.select {|k,v| k > 0}
        @@mem_for_global = @@dir[0]
        tmp_mem_scps = scope_dirs.values.inject(:+)
        @@mem_for_scopes = tmp_mem_scps if tmp_mem_scps != nil
        @@mem_for_ctes = @@dir[-2]
        @@mem_for_temp = @@dir[-1]

        @@dir[-2] = 0
        @@dir[-1] = @@mem_for_ctes + @@mem_for_global + @@mem_for_scopes
        @@dir[0] = @@mem_for_ctes

        # @@dir[-1]
        #     case
        #     when @scope > 0
        #         @direccion + sum
        #     when @scope == 0
        #         @direccion + @@dir[-2]
        #     when @scope == -1
        #         scopes = @@dir.select {|k,v| k >= 0}
        #         sum = scopes.values.inject(:+)
        #         @direccion + sum
        #     else
        #         @direccion
        #     end
    end

    def self.mem_info
        [@@mem_for_ctes,@@mem_for_global,@@mem_for_scopes,@@mem_for_temp]
    end
end
