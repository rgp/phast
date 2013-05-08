describe "Elda" do
    it 'Factorial Ciclico' do
        %x[make f=elda/factorial_ciclico].should == true#TODO resultado
    end
    it 'Factorial Recursivo' do
        %x[make f=elda/factorial_recursivo].should == true#TODO resultado
    end
    it 'Fibonacci Ciclico' do
        %x[make f=elda/fibonacci_ciclico].should == true#TODO resultado
    end
    it 'Fibonacci Recursivo' do
        %x[make f=elda/fibonacci_recursivo].should == true#TODO resultado
    end
    it 'Busqueda en Vector' do
        %x[make f=elda/busq_vector].should == true#TODO resultado
    end
    it 'Sort para un Vector' do
        %x[make f=elda/sort_vector].should == true#TODO resultado
    end
end
