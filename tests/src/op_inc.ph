<?
a = 1;
b = a + ++a + a;
println("Resultado debe ser:");
println("2");
println("6");
println(a); 
println(b);

a = 1;
b = a + a++ + a;
println("Resultado debe ser:");
println("\t2");
println("\t5");
println(a);
println(b);

println("Variables no inicializadas: c");

c++;
println("c = ",c);

a = 1;
b = a + --a + a;
println("Resultado debe ser:");
println("0");
println("0");
println(a); 
println(b);

a = 1;
b = a + a-- + a;
println("Resultado debe ser:");
println("\t2");
println("\t5");
println(a);
println(b);

println("Variables no inicializadas: d");

d--;
println("d = ",d);

?>
