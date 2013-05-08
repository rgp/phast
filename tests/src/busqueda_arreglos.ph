<?

fun busqueda_lineal (a, n)
{
    x = 0;
    while (a[x] != n)
    {
        x++;
    }
    if (a[x] == n)
    {
        return x;
    }
    else
    {
        return 100;
    }
}

a = [1,2,3,4,5];
println(busqueda_lineal(a, 3));

?>
