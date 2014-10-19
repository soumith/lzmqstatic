CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.8)
IF(LUAROCKS_PREFIX)
  MESSAGE(STATUS "Installing lzmqstatic through Luarocks")
  STRING(REGEX REPLACE "(.*)lib/luarocks/rocks.*" "\\1" CMAKE_INSTALL_PREFIX  "${LUAROCKS_PREFIX}")
  MESSAGE(STATUS "Prefix inferred from Luarocks: ${CMAKE_INSTALL_PREFIX}")
ENDIF()

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/include)
INCLUDE_DIRECTORIES(${LUA_INCDIR})
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/src)

set ( LZMQ_DEFINE LUAZMQ_USE_SEND_AS_BUF LUAZMQ_USE_TEMP_BUFFERS LUAZMQ_USE_ERR_TYPE_OBJECT )

set ( src
  src/lzmq.c     src/lzutils.c src/poller.c
  src/zcontext.c src/zerror.c  src/zmsg.c
  src/zpoller.c  src/zsocket.c
)


SET(luasrc luasrc/threads.lua luasrc/poller.lua luasrc/loop.lua luasrc/llthreads/ex.lua luasrc/impl/loop.lua luasrc/impl/threads.lua)

ADD_LIBRARY(lzmqstatic MODULE ${src})

MESSAGE("${LUA_LIBDIR}")

TARGET_LINK_LIBRARIES(lzmqstatic "${CMAKE_CURRENT_SOURCE_DIR}/lib/lib/libzmq.a" "${LUA_LIBDIR}/libluajit.dylib" stdc++ gssapi_krb5)

SET_TARGET_PROPERTIES(lzmqstatic PROPERTIES
      PREFIX "lib"
      IMPORT_PREFIX "lib"
      INSTALL_NAME_DIR "${LUA_LIBDIR}"
      COMPILE_DEFINITIONS "${LZMQ_DEFINE}"
)

