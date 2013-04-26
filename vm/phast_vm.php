<?php 

$source = array();
$start = 0;
$EOF = 0;

$globals = 0;
$temporals = 0;
$constants = 0;

#Iterators
$curr_reg = $start;
$next_free_mem = 0; // siguiente espacio en memoria disponible

#Memory
$memoria = array();

#Stacks
$offset_stack = array($next_free_mem); // stack de offsets para mapear memoria al modulo actual
$params = array();
$call_stack = array();



function loadFile()
{
    global $argv, $EOF, $source;

    $dir = exec("pwd")."/";
    if(count($argv) <= 1)
        die("Please specify a program to run\n");
    $file = $dir.$argv[1];
    if(!is_file($file))
        die("Phast:\n Could not read file => $file\n");

    $file_handle = fopen($file, "r+");
    if(!$file_handle)
    {
        echo "Error reading program.\n";
        die();
    }
    else
    {
        while ($line = fgets($file_handle)) 
        {
            $source[] = split("\t",str_replace("\n","",$line));
            $EOF++;
        }
        fclose($file_handle);
    }
}

function readHeader()
{
    global $start, $source, $constants, $temporals, $globals, $EOF;

    $start = $source[0][0];
    array_shift($source); //START

    $constants = $source[0][0];
    array_shift($source); //CTES

    $globals = $source[0][0];
    array_shift($source); //GLOBS

    $temporals = $source[0][0];
    array_shift($source); //TMPS GLOB

    $EOF -= 4 + $constants;
}

function loadMemory()
{
    global $source, $memoria, $next_free_mem, $constants;

    for ($i = 0; $i < $constants; $i++)
    {
        $type = $source[0][1];
        switch($type)
        {
        case 2:
            $memoria[$source[0][0]] = (int)$source[0][2];
            break;
        case 3:
            $memoria[$source[0][0]] = (float)$source[0][2];
            break;
        case 4:
            $memoria[$source[0][0]] = (string)$source[0][2];
            break;
        default:
            echo "ERROR\n";
            echo $type."\n";
            break;
        }
        array_shift($source);
        $next_free_mem++;
    }

}

function getRegistry($position)
{
    global $memoria, $offset_stack;

    if($position < 0)
        return (-1)*$position;
    return end($offset_stack)+$position;
}

function resultType($o1,$o2)
{
    $o1 = gettype($o1);
    $o2 = gettype($o2);

    switch (true){
        case $o1 == "string":
        case $o2 == "string":
            return "string";
            break;
        case $o1 == "double":
        case $o2 == "double":
            return "double";
            break;
        case $o1 == "integer":
        case $o2 == "integer":
            return "integer";
            break;
        case $o1 == "boolean":
        case $o2 == "boolean":
            return "boolean";
            break;
        case $o1 == "NULL":
        case $o2 == "NULL":
            return "NULL";
            break;
    }
}

loadFile();
readHeader();
loadMemory();

$offset_stack[] = $next_free_mem; // stack de offsets para mapear memoria al modulo actual

$curr_reg = $start;

while($curr_reg < $EOF)
{
    $instruccion = $source[$curr_reg];
    switch($instruccion[0])
    {
        #Flow Control instructions
    case 1: // GOTO
        $curr_reg = (int)$instruccion[3];
        break;
    case 2: // GOTOF
        $comp = $memoria[getRegistry((int)$instruccion[1])];
        if($comp == false){
            $curr_reg = (int)$instruccion[3];
        }else{
            $curr_reg++;
        }
        break;
    case 3: // GOTOV
        $comp = $memoria[getRegistry((int)$instruccion[1])];
        if($comp == true){
            $curr_reg = (int)$instruccion[3];
        }else{
            $curr_reg++;
        }
        break;
    case 4: // CALL
        // meter al offset_stack la posicion donde se puede empezar a utilizar la memoria
        array_push($offset_stack,$next_free_mem);
        // actualizar la nueva posicion ocupada de memoria
        $next_free_mem += (int)$instruccion[1]; //locales
        $next_free_mem += (int)$instruccion[2]; //temporales
        // guardar quad al que se va a regresar en el RETURN
        $call_stack[] = ++$curr_reg;
        // ir al quad correspondiente a la funcion llamada
        $curr_reg = (int)$instruccion[3]; 
        break;

        #Arithmetic instructions
    case 5: // SUM
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $rtype = resultType($op1,$op2);

        switch ($rtype)
        {
            case "NULL":
                $resultado = 0;
                break;
            case "boolean":
            case "integer":
            case "double":
                $resultado = $op1 + $op2;
                break;
            case "string":
                $resultado = $op1.$op2;
                break;
        }
        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 6: // MUL
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $rtype = resultType($op1,$op2);

        switch ($rtype)
        {
            case "NULL":
                $resultado = 0;
                break;
            case "boolean":
            case "integer":
            case "double":
                $resultado = $op1*$op2;
                break;
            case "string":
                $resultado = 0;
                break;
        }

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 7: // DIV
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = $memoria[getRegistry((int)$instruccion[1])] / $memoria[getRegistry((int)$instruccion[2])];
        $curr_reg++;
        break;
    case 8: // REST
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = $memoria[getRegistry((int)$instruccion[1])] - $memoria[getRegistry((int)$instruccion[2])];
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
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = $memoria[getRegistry((int)$instruccion[1])];
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
    case 16: //EQ
        $o1 = $memoria[getRegistry((int)$instruccion[1])];
        $o2 = $memoria[getRegistry((int)$instruccion[2])];
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = (bool)($o1 == $o2);
        $curr_reg++;
        break;
    case 17: //RET
        if(!empty($instruccion[3]))
            $return_var = $memoria[getRegistry((int)$instruccion[3])];

        // sacar del offset_stack la posicion donde se puede empezar a utilizar la memoria
        $clean = $next_free_mem;
        $next_free_mem = array_pop($offset_stack);
        print_r("AA");
        for($i = $next_free_mem; $i <= $clean; $i++){
            unset($memoria[$i]);
        }
        $curr_reg = array_pop($call_stack);
        break;
    case 18: //PRT
        while(!empty($params))
        {
            $param = array_shift($params);
            echo $param;
        }
        $curr_reg++;
        break;
    case 19: //ARG
        $param = array_shift($params);
        $memoria[getRegistry((int)$instruccion[3])] = $param;
        $curr_reg++;
        break;
    case 20: //PARAM
        array_push($params,$memoria[getRegistry((int)$instruccion[3])]);
        $curr_reg++;
        break;
    case 21: //RVT
        $memoria[getRegistry((int)$instruccion[3])] = $return_var;
        $curr_reg++;
        break;
    case 22: //PRTLN
        while(!empty($params))
        {
            $param = array_shift($params);
            echo $param;
        }
        echo "\n";
        $curr_reg++;
        break;
    default: //RANDOM ? WTF
        echo "died at: ".$curr_reg."\n";
        echo "Unknown instruction:\n".implode("\t",$instruccion);
        die();
    }
}
?> 
