class Phast::Parser

rule

programa: import main funciones

import: KEY_IMPORT STRING
      |

main: KEY_MAIN '('')' {setup_scope} bloque {update_scope}

bloque: '{' bloque_p '}'
bloque_p: estatuto bloque_p
        |

funciones: funcion funciones
        |

funcion: KEY_FUNC ID {setup_scope}'(' params ')' return bloque {update_scope}

return: tipo_p
      |


llamada_funcion: ID '(' llamada_funcion_p ')'
llamada_funcion_p: asignacion_p llamada_funcion_pp
                |
llamada_funcion_pp: ',' asignacion_p llamada_funcion_pp
                |

estatuto: vars
      | asignacion
      | llamada_funcion
      | condicion
      | ciclo

id: ID {check_for_existance(val[0])}

tipo: tipo_p {@types.push val[0];}

tipo_p: KEY_STRING 
    | KEY_INT
    | KEY_FLOAT
    | KEY_BOOLEAN

params: tipo ID params_p {add_to_vars val[1], true}
      |

params_p: ',' tipo ID params_p {add_to_vars val[2], true}
      |

vars: KEY_VAR tipo vars_aux vars_p {add_to_vars val[2]}
vars_p: ',' vars_aux vars_p {add_to_vars val[1]}
      |
      
vars_aux: ID '[' expresion ']'
        | ID

ciclo: while

while: KEY_WHILE '(' estatuto ')' bloque

condicion: KEY_IF '(' estatuto ')' bloque else

else: KEY_ELSE bloque
    |

asignacion: id_o_arreglo '=' asignacion_p

asignacion_p: expresion
            | STRING
            | BOOLEAN
            | nuevo_arreglo
          
nuevo_arreglo: '{'   nuevo_arreglo_p  '}'

nuevo_arreglo_p: asignacion_p nuevo_arreglo_aux

nuevo_arreglo_aux: ',' asignacion_p nuevo_arreglo_aux
                |

id_o_arreglo: id arreglo_p

arreglo_p: '[' expresion ']'
          |

var_cte: INT
      | FLOAT
      | llamada_funcion
      | id_o_arreglo

expresion: es expresion_p

expresion_p: operacion_relacional es {}
          |

es: termino es_p

es_p: suma_resta termino es_p
    |

termino: termino_p {}
termino_p: factor termino_pp
termino_pp: mult_div factor termino_pp
         |

factor: factor_p {}
factor_p: var_cte {}
      | {} '(' expresion ')' {}
      
suma_resta: suma_resta_p { }
suma_resta_p: '+' 
            | '-' 

mult_div: mult_div_p {}
mult_div_p: '*'
          | '/'

operacion_relacional: operacion_relacional_p {}
operacion_relacional_p: '!='
                    | '>'
                    | '<'
end

---- header ----

---- inner ----
  class UndeclaredVariable < StandardError
  end
  class VariableAlreadyDeclared < StandardError
  end

  def parse(tokens)
    @tokens = tokens
    @scope = 0
    @vars = {}
    @types = []

    do_parse
  end

  def vars
    @vars
  end

  def next_token
    @tokens.shift
  end

  def setup_scope
    @vars[@scope] = {}
  end
  
  def update_scope
    @scope +=1
  end

  def add_to_vars id, is_stack=false
    type = is_stack ? @types.pop : @types.last

    if exists? id
      raise VariableAlreadyDeclared
    else
      @vars[@scope][id] = type
    end
  end

  def exists? id
      !@vars[@scope][id].nil?
  end

  def check_for_existance id
    unless exists?(id)
      raise UndeclaredVariable 
    end
  end
