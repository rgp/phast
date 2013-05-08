<?
fun bubbleSort(arr)
{
    n = 9;
    i = 0;
    while (i < (n - 1)){
        x = i;
        while (x < (n - 1))
        {
            if(arr[x] > arr[x + 1])
            {
                println("x vale ", x);
                println("voy a swapear ", arr[x], " y ", arr[x + 1]);
                tmp = arr[x];
                arr[x] = arr[x + 1];
                arr[x + 1] = tmp;
                println(arr);
            }
            x++;
        }
        i++;
    }
    return arr;
}

arr = [6,2,8,3,5,9,1,4,7];
println("***** ARREGLO ORIGINAL *****");
println(arr);
println("***** **************** *****");
arr_sorteado = bubbleSort(arr);
println(arr_sorteado);

?>

