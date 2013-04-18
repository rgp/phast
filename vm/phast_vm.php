<?php 
$dir = exec("pwd")."/";
if(count($argv) <= 1)
    die("Please specify a program to run\n");
$file = $dir.$argv[1];
if(!is_file($file))
    die("Phast:\n Could not read file => $file\n");

$file_handle = fopen($file, "r+");
if(!$file_handle){
    echo "Error reading program.\n";
    die();
}else{
    $source = array();
    $EOF = 0;
    while ($line = fgets($file_handle)) {
        $source[] = split("\t",str_replace("\n","",$line));
        $EOF++;
    }
    fclose($file_handle);

    $start = $source[0][0];
    array_shift($source); //START

    $ctes = $source[0][0];
    array_shift($source); //CTES

    $globs = $source[0][0];
    array_shift($source); //GLOBS

    $temps = $source[0][0];
    array_shift($source); //TMPS

    //TODO QUITAR ESTO**********
    $scops = $source[0][0];
    array_shift($source); //SCPS
    //**************************

    $EOF -= 5 + $ctes;

    $curr_reg = $start;

    $memoria = array();

    $offset_stack = array(0); // stack de offsets para mapear memoria al modulo actual
    $last_mem_space_used = 0; // ultimo espacio de memoria ocupado

    for ($i = 0; $i < $ctes; $i++)
    {
        $type = $source[0][2];
        switch($type)
        {
        case 2:
            $memoria[$source[0][0]] = (int)$source[0][1];
            break;
        case 3:
            $memoria[$source[0][0]] = (float)$source[0][1];
            break;
        case 4:
            $memoria[$source[0][0]] = (string)$source[0][1];
            break;
        default:
            echo "ERROR\n";
            echo $type."\n";
            break;
        }
        array_shift($source);
        $last_mem_space_used++;
    }


    while($curr_reg < $EOF)
    {
        $instruccion = $source[$curr_reg];
        switch($instruccion[0])
        {
            #Flow Control instructions
        case 1: // GOTO
            $curr_reg = (int)$instruccion[3];
            echo "GOTO ${instruccion[3]}\n";
                break;
        case 2: // GOTOF
            echo "GOTOF ${instruccion[3]}\n";
            $curr_reg++; //TODO Quitar saltos
                break;
        case 3: // GOTOV
            echo "GOTOV ${instruccion[3]}\n";
            $curr_reg++; //TODO Quitar saltos
                break;
        case 4: // CALL
            // meter al offset_stack la posicion donde se puede empezar a utilizar la memoria
            array_push($offset_stack,$last_mem_space_used);
            // actualizar la nueva posicion ocupada de memoria
            $last_mem_space_used += (int)$instruccion[1];
            // guardar quad al que se va a regresar en el RETURN
            $call_stack[] = ++$curr_reg;
            // ir al quad correspondiente a la funcion llamada
            $curr_reg = $instruccion[3]; 
                break;

            #Arithmetic instructions
        case 5: // SUM
            // echo "SUM ${instruccion[1]} ${instruccion[2]}\n";
            $memoria[((int)$instruccion[3]) + end($offset_stack))] = $memoria[(int)$instruccion[1]] + $memoria[(int)$instruccion[2]];
            $curr_reg++;
                break;
        case 6: // MUL
            // echo "MUL ${instruccion[1]} ${instruccion[2]}\n";
            $memoria[((int)$instruccion[3]) + end($offset_stack))] = $memoria[(int)$instruccion[1]] * $memoria[(int)$instruccion[2]];
            $curr_reg++;
                break;
        case 7: // DIV
            // echo "DIV ${instruccion[1]} ${instruccion[2]}\n";
            $memoria[((int)$instruccion[3]) + end($offset_stack))] = $memoria[(int)$instruccion[1]] / $memoria[(int)$instruccion[2]];
            $curr_reg++;
                break;
        case 8: // REST
            // echo "REST ${instruccion[1]} ${instruccion[2]}\n";
            $memoria[((int)$instruccion[3]) + end($offset_stack))] = $memoria[(int)$instruccion[1]] - $memoria[(int)$instruccion[2]];
            $curr_reg++;
                break;

            #Logical instructions
        case 9: // AND
            echo "AND ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 10: // OR
            echo "OR ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 11: // ASIGN
            // echo "ASIGN ${instruccion[1]} ${instruccion[2]}\n";
            $memoria[(int)$instruccion[3]] = $memoria[(int)$instruccion[1]];
            $curr_reg++;
                break;
        case 12:
            echo "GT ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 13:
            echo "LT ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 14:
            echo "EGT ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 15:
            echo "ELT ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 16:
            echo "EQ ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 17:
            if(!empty($instruccion[3]))
                $return_var = $instruccion[3];
            $curr_reg = array_pop($call_stack);
                break;
        default:
            echo "died at: ".$curr_reg."\n";
            die();
            // echo "Unknown instruction:\n".implode("\t",$instruccion);
            die();
        }
    }
    qprint_r($memoria);
}
?> 
