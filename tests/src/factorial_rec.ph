<?
verbose{
    $start = microtime(true);
}
fun factorial(n){
    if (n == 1) {
        return n;
    }
    else {
        return n * factorial(n-1);
    }
}

println(fib(5));
verbose{
    echo(microtime(true) - $start);
    echo("\n");
}
?>
