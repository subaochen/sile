#!/bin/sh
cd $APPVEYOR_BUILD_FOLDER

# Pretend we are on travis so that the Lua build code can be reused
export TRAVIS_BUILD_DIR=/c/projects/sile/
export TRAVIS_OS_NAME=mingw
export LUAROCKS=2.2.2
source .travis/setenv_lua.sh
export LUA_HOME_DIR=$TRAVIS_BUILD_DIR/install/lua
export LUA=~/.lua/lua
export LUA_INCLUDE=-I$LUA_HOME_DIR/include
export LD_LIBRARY_PATH=$LUA_HOME_DIR/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$LUA_HOME_DIR/lib:$LD_LIBRARY_PATH
export LD_RUN_PATH=$LUA_HOME_DIR/lib:$LD_RUN_PATH
export PATH=.travis:$PATH

lua -e "print('Hello ' .. _VERSION .. '!')"

luarocks install lpeg
luarocks install lua-zlib
luarocks install luaexpat
luarocks install luafilesystem
luarocks install lua_cliargs 2.3-3
luarocks install busted
luarocks install luacov 0.8-1
luarocks install luacov-coveralls

./bootstrap.sh || exit 1
./configure || exit 1
make || exit 1