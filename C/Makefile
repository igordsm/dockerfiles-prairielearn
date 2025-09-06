
src_files := $(wildcard *.c)
pre_compiled := $(wildcard *.o)
CC = gcc
CFLAGS_TEST = -Wall -std=gnu99 -Og -g -fsanitize=address -static-libasan
ASANLOG = /usr/bin/asanlog
TARGET = ./test

test: $(src_files) FORCE
	$(CC) $(CFLAGS_TEST)  $(src_files)  $(pre_compiled) `pkg-config --libs check` -o $(TARGET)
	$(ASANLOG) $(TARGET)

clean:
	rm test

FORCE: 

