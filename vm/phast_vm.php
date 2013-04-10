<?php 
$dir = exec("pwd")."/";
if(count($argv) <= 1)
    die("Please specify a program to run\n");
$file = $dir.$argv[1];
if(!is_file($file))
    die("Phast:\n Could not read file => $file\n");

$file_handle = fopen($file, "r+");
if($file_handle){
while (!feof($file_handle)) {
   $line = fgets($file_handle);
   echo $line;
}
fclose($file_handle);
}else
    echo "Error reading program.\n";
?> 
