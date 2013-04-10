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

    $curr_reg = 0;

    while($curr_reg < $EOF)
    {
        $instruccion = $source[$curr_reg];
        switch($instruccion[0])
        {
            #Flow Control instructions
        case "GotoF":
            echo "GOTOF ${instruccion[3]}\n";
            $curr_reg++; //TODO Quitar saltos
                break;
        case "GotoV":
            echo "GOTOV ${instruccion[3]}\n";
            $curr_reg++; //TODO Quitar saltos
                break;
        case "Goto":
            // $curr_reg = (int)$instruccion[3];
            $curr_reg++; //TODO Quitar saltos
            echo "GOTO ${instruccion[3]}\n";
                break;
            #Arithmetic instructions
        case "+":
            echo "SUM ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case "*":
            echo "MUL ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
            #Logical instructions
        case "=":
            echo "ASIGN ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case ">":
            echo "GT ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case "<":
            echo "LT ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        default:
            echo $curr_reg;
            // echo "Unknown instruction:\n".implode("\t",$instruccion);
            die();
        }

    }

}
?> 
