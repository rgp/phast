run: compile
	ruby driver.rb $(f)
debug: compile
	ruby driver.rb -d $(f) 
compile: clean rbs/parser.rb rbs/scanner.rb libs

rbs/scanner.rb:
	cp src/scanner.rb rbs/scanner.rb
rbs/parser.rb:
	racc -o rbs/parser.rb src/parser.y
libs:
	cp -R src/lib/ rbs/lib/
clean:
	rm -Rf rbs/*

