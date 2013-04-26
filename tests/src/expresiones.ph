<?
a;
println("a = ",a);

b = 4;
println("b = ",b);

a = b * 2;
println("a = ",a);

b = a;
println("b = ",b);

c = "Ric";
println("c = ",c);

a = b = c;
println("a = ",a);
println("b = ",b);
println("c = ",c);

a = 73 - 69;
println("a = ",a);

b = 100/50;
println("b = ",b);

t = 2 + 3;
println("t = ",t);
t = 11 + a;
println("t = ",t);
t = 11 + a - (2 + 3);
println("t = ",t);
t = b * (11 + a - (2 + 3));
println("t = ",t);
println("");
t = 6 * 2;
println("t = ",t);
t = a + a;
println("t = ",t);
t = 6 * 2 / (a + a);
println("t = ",t);


println("");
c = b * (11 + a - (2 + 3)) + 6 * 2 / (a + a);
println("c = ",c);
?>
