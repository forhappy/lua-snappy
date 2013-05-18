LUA_SNAPPY_MAJOR="0"
LUA_SNAPPY_MINOR="1"
LUA_SNAPPY_PATCHLEVEL="0"

CC=g++
CCFLAGS=-fPIC -Wall -g -O2
LDFLAGS=-shared

all:snappy.so

snappy.so:lua-snappy.o snappy.o snappy-c.o\
	snappy-sinksource.o snappy-stubs-interal.o
	$(CC) $(LDFLAGS) -o $@ $^ 

lua-snappy.o:lua-snappy.cc
	$(CC) -o $@ -c $(CCFLAGS) $^

snappy.o:snappy/snappy.cc
	$(CC) -o $@ -c $(CCFLAGS) $^

snappy-c.o:snappy/snappy-c.cc
	$(CC) -o $@ -c $(CCFLAGS) $^

snappy-sinksource.o:snappy/snappy-sinksource.cc
	$(CC) -o $@ -c $(CCFLAGS) $^

snappy-stubs-interal.o:snappy/snappy-stubs-internal.cc
	$(CC) -o $@ -c $(CCFLAGS) $^

.PHONY:clean

clean:
	rm -f *.o snappy.so

