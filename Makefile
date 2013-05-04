run: prepare
	@echo "Execute VM....."
	@./phast tests/bin/fibonacci.o
prepare: clean
	@echo "Compiling ....."
	@./phast -c tests/src/fibonacci.ph -o tests/bin/fibonacci.o	
clean:
	@rm -Rf tests/bin/*
