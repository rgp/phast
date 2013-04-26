run: prepare
	./phast tests/bin/expresiones.o
prepare: clean
	./phast -c tests/src/expresiones.ph > tests/bin/expresiones.o	
clean:
	rm -Rf tests/bin/*


