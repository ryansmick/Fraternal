all: fraternal

GCC = /usr/bin/gcc
COMPILER_FILES = 

fraternal: scanner.c parser.tab.c $(COMPILER_FILES)
	$(GCC) -Wall -Wno-unused-label $^ -o $@

debug: scanner.c parser.tab.c $(COMPILER_FILES)
	$(GCC) -Wall -Wno-unused-label -g $^ -o fraternal_$@

scanner.c: scanner.flex
	flex -o $@ $^

parser.tab.c parser.tab.h: parser.bison
	bison --defines=parser.tab.h --output=$@ -v $^

clean:
	rm -f fraternal fraternal_debug scanner.c parser.tab.c parser.tab.h parser.output

