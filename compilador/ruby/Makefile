run: clean rbs/parser.rb rbs/scanner.rb libs
	ruby driver.rb $(f)

rbs/scanner.rb:
	cp src/scanner.rb rbs/scanner.rb
rbs/parser.rb:
	racc -o rbs/parser.rb src/parser.y
libs:
	cp -R src/lib/ rbs/lib/
clean:
	rm -Rf rbs/*

