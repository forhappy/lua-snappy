Lua-snappy
==========

Lua binding of google's [snappy](https://code.google.com/p/snappy/ "snappy") compressor.

How to Build
============
First of all, configure your system using:

        lua-snappy$ ./sysconfig

Then, build lua-snappy with make:

        lua-snappy$ make

That'all, enjoy snappy in lua.

How to Use
==========
Here is a sample usage in shell:

        Lua 5.1.4 Copyright (C) 1994-2008 Lua.org, PUC-Rio
        > require "snappy"
        > compressed = snappy.compress("hello world!")
        > indicator = snappy.validate_compressed_buffer(compressed)
        > print(indicator)
        true
        > uncompressed = snappy.uncompress(compressed) -- snappy.decompress(compressed) also works.
        > print(uncompressed)
        hello world!

Report Bugs
===========
Please report bugs to haipingf AT gmail DOT com
