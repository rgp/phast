run: clean rbs/parser.rb rbs/scanner.rb
	ruby driver.rb $(f)

rbs/scanner.rb:
	cp src/scanner.rb rbs/scanner.rb
rbs/parser.rb:
	racc -o rbs/parser.rb src/parser.y
clean:
	rm -f rbs/*

