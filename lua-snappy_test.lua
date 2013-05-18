-- lua-snappy_test.lua
local snappy = require "snappy"
compressed = snappy.compress("hello world!")
uncompressed = snappy.uncompress(compressed) -- snappy.decompress(compressed) also works.
print(uncompressed)

