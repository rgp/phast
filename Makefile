run: prepare
	@echo "Execute VM....."
	@./phast tests/bin/op_logicos.pho
prepare: 
	@echo "Compiling ....."
	@./phast -c tests/src/op_logicos.ph -o tests/bin/op_logicos.pho	
clean:
	@rm -Rf tests/bin/*
