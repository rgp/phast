<?
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
?>
