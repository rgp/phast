<?PHP 
$source = array();
$start = 0;
$EOF = 0;

$globals = 0;
$temporals = 0;
$constants = 0;

$return_var = NULL;
$mem = false;
$params_hash = NULL;
$memento = array();

#Iterators
$curr_reg = $start;
$next_free_mem = 0; // siguiente espacio en memoria disponible

#Memory
$memoria = array();

#Stacks
$offset_stack = array($next_free_mem); // stack de offsets para mapear memoria al modulo actual
$params = array();
$call_stack = array();

$dir = exec("pwd")."/";

if(count($argv) <= 1)
    die("Please specify a program to run\n");

$file = $dir.$argv[1];

if(!is_file($file))
    die("Phast:\n Could not read file => $file\n");

function loadFile()
{
    global $argv, $source, $dir, $file;

    $file_handle = fopen($file, "r+");
    if(!$file_handle)
    {
        echo "Error reading program.\n";
        die();
    }
    else
    {
        $str = "";
        while ($line = fgets($file_handle)) 
        {
            $line = substr($line,0,-1);
            $ech = substr($line, -1);

            $str .= $line;
            if(ord($ech) == 0){
                $source[] = substr($str,0,-1);
                $str = "";
            }

        }
        fclose($file_handle);
    }
}

function readQuads()
{
    global $source, $EOF;
    foreach($source as &$s){
        $s = explode("\t",$s,4);
        $EOF++;
    }
}

function readHeader()
{
    global $start, $source, $constants, $temporals, $globals;

    $start = (int)$source[0];
    array_shift($source); //START

    $constants = (int)$source[0];
    array_shift($source); //CTES

    $globals = (int)$source[0];
    array_shift($source); //GLOBS

    $temporals = (int)$source[0];
    array_shift($source); //TMPS GLOB
}

function loadMemory()
{
    global $source, $memoria, $next_free_mem, $constants;

    for ($i = 0; $i < $constants; $i++)
    {
        $source[0] = explode("\t",$source[0],3);
        $type = $source[0][1];
        switch($type)
        {
        case 0:
            $memoria[$source[0][0]] = NULL;
            break;
        case 1:
            $memoria[$source[0][0]] = strToLower($source[0][2]) == "false" ? false : true;
            break;
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
readQuads();

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
                $resultado = $op1 * $op2;
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
                $resultado = $op1 / $op2;
                break;
            case "string":
                $resultado = 0;
                break;
        }
        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 8: // REST
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
                $resultado = $op1 - $op2;
                break;
            case "string":
                $resultado = 0;
                break;
        }
        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;

        #Logical instructions
    case 9: // AND
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 And $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 10: // OR
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 Or $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 11: // ASIGN
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = $memoria[getRegistry((int)$instruccion[1])];
        $curr_reg++;
        break;
    case 12: // GREATER THAN
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 > $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 13: // LESS THAN 
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 < $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 14: // GREATER THAN OR EQUAL
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 >= $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 15: // LESS THAN OR EQUAL
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 <= $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 16: //EQ
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 == $op2)) ? true : false;

        $memoria[$saveTo] = $resultado;
        $curr_reg++;
        break;
    case 17: //RET
        if(!is_null($instruccion[3])){
            $dir = getRegistry((int)$instruccion[3]);
            $return_var = $memoria[$dir];
        }
        if(!is_null($instruccion[1])){
            $params_hash = $memoria[getRegistry((int)$instruccion[1])];
            $memento[$params_hash] = $return_var;
            $params_hash = NULL;
        }
        // sacar del offset_stack la posicion donde se puede empezar a utilizar la memoria
        $clean = $next_free_mem;
        $next_free_mem = array_pop($offset_stack);
        for($i = $next_free_mem; $i <= $clean; $i++){
            unset($memoria[$i]);
        }
        $curr_reg = array_pop($call_stack);
        break;
    case 18: //PRT
        while(!empty($params))
        {
            $param = array_shift($params);
            if(gettype($param) == "object")
                echo "Array";
            else
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
            if(gettype($param) == "object")
                echo "Array";
            else
                echo $param;
        }
        echo "\n";
        $curr_reg++;
        break;
    case 23: //AR DEFINITION
        $saveTo = getRegistry((int)$instruccion[3]);

        // $memoria[$saveTo] = new SplFixedArray((int)$instruccion[1]);
        $memoria[$saveTo] = array();
        $curr_reg++;
        break;
    case 24: //ASIGN TO AR
        $saveTo = getRegistry((int)$instruccion[2]);
        $position = (int)$instruccion[3];

        $memoria[$saveTo][$position] = $memoria[getRegistry((int)$instruccion[1])];
        $curr_reg++;
        break;
    case 25: //ARRLD Array Load .... carga un arreglo de memoria a un tempora para usarse
        $saveTo = getRegistry((int)$instruccion[3]);
        $load = getRegistry((int)$instruccion[1]);
        $memoria[$saveTo] = &$memoria[$load];
        $curr_reg++;
        break;
    case 26: //ARRVLD  ... valida que el índice esté dentro de rango
        $addr = getRegistry((int)$instruccion[2]);
        $ind = getRegistry((int)$instruccion[1]);
        if($memoria[$ind] < count($memoria[$addr]) && $memoria[$ind] >= 0){
            //all good
        }else{
            echo "Fatal error: Out of Bounds";
            die();
        }
        $curr_reg++;
        break;
    case 27: //ARRIND ... carga una cajita del arreglo en una temporal para usarse
        $saveTo = getRegistry((int)$instruccion[3]);
        $index = $memoria[getRegistry((int)$instruccion[2])];
        $load = getRegistry((int)$instruccion[1]);
        $memoria[$saveTo] = &$memoria[$load][$index];
        $curr_reg++;
        break;
    case 28: //VERB verbose
        $str = $memoria[getRegistry((int)$instruccion[3])];
        eval($str);
        $curr_reg++;
        break;
    case 29: //EXST exists
        if(count($params) < 2){
            echo "Function exists requires 2 params";
            die();
        }
        $p1 = array_shift($params);
        $p2 = array_shift($params);
        $memoria[getRegistry((int)$instruccion[3])] = empty($p1) ? $p2 : $p1;
        $curr_reg++;
        break;
    case 30: //LNK link file
        if(count($params) < 1){
            echo "Function exists requires 1 param";
            die();
        }
        foreach($params as $p){
            include($p);
        }
        $params = array();
        break;
    case 31: //LNKH link file
        if(count($params) < 1){
            echo "Function exists requires 1 param";
            die();
        }
        foreach($params as $p){
            require($p);
        }
        $params = array();
        break;
    case 32: // XOR
        $saveTo = getRegistry((int)$instruccion[3]);
        $op1 = $memoria[getRegistry((int)$instruccion[1])];
        $op2 = $memoria[getRegistry((int)$instruccion[2])];

        $resultado = ((int)($op1 Xor $op2)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 33: // OBJ
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = array();
        $curr_reg++;
        break;
    case 34: //NOT
        $saveTo = getRegistry((int)$instruccion[3]);
        $op = $memoria[getRegistry((int)$instruccion[1])];

        $resultado = ((int)(!$op)) ? true : false;

        $memoria[$saveTo] =  $resultado;
        $curr_reg++;
        break;
    case 35: // ATTR
        $read = getRegistry((int)$instruccion[1]);
        $saveTo = getRegistry((int)$instruccion[2]);
        $memoria[$saveTo][$instruccion[3]] = $memoria[$read];
        $curr_reg++;
        break;
    case 36: // ATTR_ACC
        $inst = getRegistry((int)$instruccion[1]);
        $saveTo = getRegistry((int)$instruccion[3]);
        $memoria[$saveTo] = &$memoria[$inst][(int)$instruccion[2]];
        $curr_reg++;
        break;
    case 37: // MEM
        $params_hash = $instruccion[1].serialize($params);
        if(isset($memento[$params_hash])){
            $params = array();
            $return_var = $memento[$params_hash];
            $clean = $next_free_mem;
            $next_free_mem = array_pop($offset_stack);
            for($i = $next_free_mem; $i <= $clean; $i++){
                unset($memoria[$i]);
            }
            $curr_reg = array_pop($call_stack);
        }else{
            $memoria[(int)getRegistry($instruccion[2])] = $params_hash;
            $curr_reg++;
        }
        break;
    default: //RANDOM ? WTF
        echo "\ndied at: ".$curr_reg."\n";
        echo "Unknown instruction:\n".implode("\t",$instruccion);
        die();
    }
}
?>
