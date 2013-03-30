package = "lua-snappy"
version = "0.1-0"
source = {
   url = "git://github.com/forhappy/lua-snappy.git",
   branch = "0.1.0"
}
description = {
   summary = "Lua binding of google's snappy compressor for Lua 5.1/5.2",
   homepage = "http://github.com/forhappy/lua-snappy",
   license = "Two-clause BSD",
   maintainer = "Fu Haiping<haipingf@gmail.com>"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      snappy = {
         sources = {
            "lua-snappy.cc",
         }
      }
   }
}
