LUA_SNAPPY_MAJOR="0"
LUA_SNAPPY_MINOR="1"
LUA_SNAPPY_PATCHLEVEL="0"

CC=g++
CPPFLAGS=-fPIC -shared -Wall -g -O2
all:snappy.so

snappy.so:lua-snappy.o snappy.o snappy-c.o\
	snappy-sinksource.o snappy-stubs-interal.o
	$(CC)  $(CPPFLAGS) -o $@ $^

lua-snappy.o:lua-snappy.cc
	$(CC) -o $@ -c $^

snappy.o:snappy/snappy.cc
	$(CC) -o $@ -c $^

snappy-c.o:snappy/snappy-c.cc
	$(CC) -o $@ -c $^

snappy-sinksource.o:snappy/snappy-sinksource.cc
	$(CC) -o $@ -c $^

snappy-stubs-interal.o:snappy/snappy-stubs-internal.cc
	$(CC) -o $@ -c $^

.PHONY:clean

clean:
	rm *.o snappy.so
