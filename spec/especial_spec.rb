describe "Especial" do
    it 'Renders Webpage' do
        %x[make spec f=elda/especial].should == "120\n"
    end
end

