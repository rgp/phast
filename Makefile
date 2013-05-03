run: prepare
	./phast tests/bin/arreglos.o
prepare: clean
	./phast -c tests/src/arreglos.ph > tests/bin/arreglos.o	
clean:
	rm -Rf tests/bin/*


