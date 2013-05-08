<?
verbose{
    $start = microtime(true);
}
fun factorial(n){
    a = 1;
    while (n > 1)
    {
        a = a * n;
        n--;
    }
    return a;
}

println(factorial(5));
verbose{
    echo(microtime(true) - $start);
    echo("\n");
}
?>
