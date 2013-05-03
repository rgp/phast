run: prepare
	./phast tests/bin/fibonacci.o
prepare: clean
	./phast -c tests/src/fibonacci.ph > tests/bin/fibonacci.o	
clean:
	rm -Rf tests/bin/*


