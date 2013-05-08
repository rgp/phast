<?
verbose{
    $start = microtime(true);
}
fun aa(a){
return 4;
return 4;
}
fun mem fib(n){
    if (n < 2) {
        return n;
    }
    else {
        return fib(n-1)+fib(n-2);
    }
}

println(fib(30));
verbose{
    echo(microtime(true) - $start);
    echo("\n");
}
?>
