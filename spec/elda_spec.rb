describe "Elda" do
    it 'Factorial Ciclico' do
        %x[make spec f=elda/factorial].should == "120\n"
    end
    it 'Factorial Recursivo' do
        %x[make spec f=elda/factorial_rec].should == "120\n"
    end
    it 'Fibonacci Ciclico' do
        %x[make spec f=elda/fibonacci].should == "5\n"
    end
    it 'Fibonacci Recursivo' do
        %x[make spec f=elda/fibonacci_rec].should == "5\n"
    end
    it 'Busqueda en Vector' do
        %x[make spec f=elda/busqueda_arreglos].should == "2\n"
    end
    it 'Sort para un Vector' do
        %x[make spec f=elda/sort_arreglos].should == "[1,2,3,4,5,6,7,8,9]\n"
    end
end
