<?
verbose{
    $start = microtime(true);
}
fun fib(n){
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
