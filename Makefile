f="expr"
run: prepare
	@echo "Execute VM....."
	@./phast tests/bin/$(f).pho
spec: compile
	@./phast -c tests/src/$(f).ph -o tests/bin/$(f).pho	
	@./phast tests/bin/$(f).pho
prepare: compile
	@echo "Compiling ....."
	@./phast -c tests/src/$(f).ph -o tests/bin/$(f).pho	
clean:
	@rm -Rf tests/bin/*

compile: clean_rbs rbs/parser.rb rbs/scanner.rb libs

rbs/scanner.rb:
	@cp compilador/src/scanner.rb compilador/rbs/scanner.rb
rbs/parser.rb:
	@racc -o compilador/rbs/parser.rb compilador/src/parser.y >  /dev/null 2>&1
libs:
	@cp -R compilador/src/lib/ compilador/rbs/lib/
clean_rbs:
	@rm -Rf compilador/rbs/*.rb
	@rm -Rf compilador/rbs/lib/*.rb
