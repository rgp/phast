<?
fun factorial(n){
    if (n == 1) {
        return n;
    }
    else {
        return n * factorial(n-1);
    }
}

println(factorial(5));
?>
