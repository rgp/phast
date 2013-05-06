run: prepare
	@echo "Execute VM....."
	@./phast tests/bin/arreglos.o
prepare: 
	@echo "Compiling ....."
	@./phast -c tests/src/arreglos.ph -o tests/bin/arreglos.o	
clean:
	@rm -Rf tests/bin/*
