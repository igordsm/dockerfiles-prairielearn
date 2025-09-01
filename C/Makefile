
src_files := $(wildcard *.c)
pre_compiled := $(wildcard *.o)

test: $(src_files) FORCE
	gcc -Wall -std=gnu99 -Og -g  $(src_files)  $(pre_compiled) `pkg-config --libs check` -o test
	./test

clean:
	rm test

FORCE: 

