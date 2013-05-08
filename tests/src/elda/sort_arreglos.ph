<?
fun bubbleSort(arr){
    n = 9;
    while (n > 0){
        newr = 0;
        i = 1;
        while(i < n-1){
            if(arr[i-1] > arr[i]){
                tmp = arr[i];
                arr[i] = arr[i-1];
                arr[i-1] = tmp;
                newr = i;
            }
            i = i + 1;
        }
        n = newr;
    }
}

arr = [6,2,8,3,5,9,1,4,7];
arr_sorteado = bubbleSort(arr);
println(arr_sorteado);

?>
