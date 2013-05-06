run: prepare
	@echo "Execute VM....."
	@./phast tests/bin/expr.pho
prepare: 
	@echo "Compiling ....."
	@./phast -c tests/src/expr.ph -o tests/bin/expr.pho	
clean:
	@rm -Rf tests/bin/*
