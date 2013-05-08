f="expr"
run: prepare
	@echo "Execute VM....."
	@./phast tests/bin/$(f).pho
prepare: clean
	@echo "Compiling ....."
	@./phast -c tests/src/$(f).ph -o tests/bin/$(f).pho	
clean:
	@rm -Rf tests/bin/*
