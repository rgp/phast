<?
fun fibonacci(n){
    ant = 1;
    antant = 1;
    i = 2;
    while (i < n){
        i++;
        temp = ant;
        ant = ant + antant;
        antant = temp;
    }
    return ant;
}
println(fibonacci(5));
?>
