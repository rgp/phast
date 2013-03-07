<?
/* 
definicion de variables "on the fly"
 */
a = 3;
alfa = "string";
beta = 3.2;
perro_gato = "miau";
edad = 3;

/* definicion de arreglos */
patos = []; /* arreglo vacío */
animales = [patos, perro_gato];
construcciones = ["edificio" => "empire state","casas" => ["los pinos"], "puente" => "golden gate"]

/* ciclos */
while( a = 8 )
{
    print(a);
    /* uso de operadores */
a++; 
}


do{
	construcciones[“casas”][0][“mascotas”][] = “leon”;
}while(true);

for(i=0;i < 3; i++)
{
print(“hola”);
}

if (a + 2 > 10)
{
print(“yes!”);
}
else
{
print(“no...”);
}

verbose { $a = 5; echo $a;}
fun (a) 
{
print(a*a);
}

?>
