all: fraternal

GCC = /usr/bin/gcc
COMPILER_FILES = scanner.c parser.tab.c 
PRODUCTION_FILES = $(COMPILER_FILES) main.c
DEBUG_FILES = $(COMPILER_FILES) main_debug.c

fraternal: $(PRODUCTION_FILES)
	$(GCC) -Wall -Wno-unused-label $^ -o $@

debug: $(DEBUG_FILES)
	$(GCC) -Wall -Wno-unused-label -g $^ -o fraternal_$@

scanner.c: scanner.flex
	flex -o $@ $^

parser.tab.c parser.tab.h: parser.bison
	bison --defines=parser.tab.h --output=$@ -v $^

clean:
	rm -f fraternal fraternal_debug scanner.c parser.tab.c parser.tab.h parser.output

