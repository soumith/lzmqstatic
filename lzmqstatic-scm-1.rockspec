package = "lzmqstatic"
version = "scm-1"

source = {
   url = "git://github.com/soumith/lzmqstatic.git",
}

description = {
   summary = "Static self-contained zeromq bindings for Lua",
   detailed = [[
   Lua ZeroMQ bindings that just work irrespective of the machine or what is installed on it. 
   ZeroMQ is self-contained in this repository and is built and linked to the bindings statically.
   ]],
   homepage = "https://github.com/soumith/lzmqstatic",
   license = "LGPLV3"
}

dependencies = {
   "lua >= 5.1",
}

build = {
   type = "command",
   build_command = [[
cd zeromq-4.1.0 && ./configure --enable-static=yes --enable-shared=no --without-documentation --with-relaxed --prefix=$(cd ../ && pwd)/lib && make install
cmake -E make_directory build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DLUA=$(LUA) -DLUALIB=$(LUALIB) -DLUA_BINDIR="$(LUA_BINDIR)" -DLUA_INCDIR="$(LUA_INCDIR)" -DLUA_LIBDIR="$(LUA_LIBDIR)" -DLUADIR="$(LUADIR)" -DLIBDIR="$(LIBDIR)" -DCMAKE_INSTALL_PREFIX="$(PREFIX)" && $(MAKE)
]],
   install_command = "cd build && $(MAKE) install"
}
