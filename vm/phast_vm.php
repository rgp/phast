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

    $curr_reg = $source[0][0];
    array_shift($source);
    array_shift($source);
    array_shift($source);
    array_shift($source);
    array_shift($source);

    while($curr_reg < $EOF)
    {
        $instruccion = $source[$curr_reg];
        switch($instruccion[0])
        {
            #Flow Control instructions
        case 1:
            $curr_reg = (int)$instruccion[3];
            // $curr_reg++; //TODO Quitar saltos
            echo "GOTO ${instruccion[3]}\n";
                break;
        case 2:
            echo "GOTOF ${instruccion[3]}\n";
            $curr_reg++; //TODO Quitar saltos
                break;
        case 3:
            echo "GOTOV ${instruccion[3]}\n";
            $curr_reg++; //TODO Quitar saltos
                break;
        case 4:
            // $curr_reg = (int)$instruccion[3];
            $curr_reg++; //TODO Quitar saltos
            echo "CALL ${instruccion[3]}\n";
                break;
            #Arithmetic instructions
        case 5:
            echo "SUM ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 6:
            echo "MUL ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 7:
            echo "DIV ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 8:
            echo "REST ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
            #Logical instructions
        case 9:
            echo "AND ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 10:
            echo "OR ${instruccion[1]} ${instruccion[2]}\n";
            $curr_reg++;
                break;
        case 11:
            echo "ASIGN ${instruccion[1]} ${instruccion[2]}\n";
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
        default:
            echo "died at: ".$curr_reg;
            die();
            // echo "Unknown instruction:\n".implode("\t",$instruccion);
            die();
        }

    }

}
?> 
