<?
verbose{
    $start = microtime(true);
}
fun fibonacci(n){
    ant = 1;
    antant = 1;
    for (i = 2; i < n; i++) {
        temp = ant;
        ant = ant + antant;
        antant = temp;
    }
    return ant;
}

println(fibonacci(1));
verbose{
    echo(microtime(true) - $start);
    echo("\n");
}
?>
