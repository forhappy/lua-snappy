/*
 * ========================================================================
 *
 *       Filename:  lua-snappy.c
 *
 *    Description:  Google snappy lua binding.
 *
 *        Created:  03/30/2013 08:17:59 PM
 *
 *         Author:  Fu Haiping (forhappy), haipingf@gmail.com
 *        Company:  ICT ( Institute Of Computing Technology, CAS )
 *
 * ========================================================================
 */

#include <stdio.h>
#include <stdlib.h>

extern "C" {
#include <lua.h>
#include <lauxlib.h>
int luaopen_snappy(lua_State *L);
}

#include "snappy/snappy-c.h"

static int lsnappy_compress(lua_State *L)
{
    size_t src_len = 0;
    const char* src = luaL_checklstring(L, 1, &src_len);
    size_t dst_max_size = snappy_max_compressed_length(src_len);
    char* dstmem = (char*)malloc(dst_max_size);
    if (dstmem != NULL) {
        if (snappy_compress(src, src_len, dstmem,
                    &dst_max_size) == SNAPPY_OK) {
            lua_pushlstring(L, dstmem, dst_max_size);
            free(dstmem);
            return 1;
        }
        free(dstmem);
    }
    return luaL_error(L, "snappy: not enough memory.");
}

static int lsnappy_uncompress(lua_State *L)
{
    size_t src_len = 0;
    size_t dst_max_size = 0;
    const char* src = luaL_checklstring(L, 1, &src_len);
    if (snappy_uncompressed_length(src, src_len, &dst_max_size)
            != SNAPPY_OK) {
        lua_pushlstring(L, "", 0);
    }
    char* dstmem = (char*)malloc(dst_max_size);
    if (dstmem != NULL) {
        if (snappy_uncompress(src, src_len, dstmem,
                    &dst_max_size) == SNAPPY_OK) {
            lua_pushlstring(L, dstmem, dst_max_size);
            free(dstmem);
            return 1;
        }
        free(dstmem);
    }
    return luaL_error(L, "snappy: not enough memory.");
}

static const luaL_Reg snappy[] =
{
    {"compress", lsnappy_compress},
    {"uncompress", lsnappy_uncompress},
    {"decompress", lsnappy_uncompress},
    {NULL, NULL}
};

int luaopen_snappy(lua_State *L)
{
#if LUA_VERSION_NUM == 502
    luaL_newlib(L, snappy);
#else
    luaL_register(L, "snappy", snappy);
#endif
    lua_pushliteral (L, "Copyright (C) 2013 Fu Haiping(forhappy)");
    lua_setfield(L, -2, "_COPYRIGHT");
    lua_pushliteral (L, "lua-snappy: lua binding of google's snappy(a fast compressor/decompressor)");
    lua_setfield(L, -2, "_DESCRIPTION");
    lua_pushliteral (L, "0.1.0");
    lua_setfield(L, -2, "_VERSION");
    return 1;
}
