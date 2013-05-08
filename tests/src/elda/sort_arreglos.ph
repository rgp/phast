<?
fun bubbleSort(a){
    n = 9;
    i = 0;
    while (i < n){
        j = 1;
        while( j < (n - i) ){
            if(a[j-1] > a[j]){
                t = a[j-1];
                a[j-1]=a[j];
                a[j]=t;
            }
            j++; 
        }
        i++;
    }
    return a;
}

arr = [6,2,8,3,5,9,1,4,7];
arr_sorteado = bubbleSort(arr);
printrec(arr_sorteado);

?>
