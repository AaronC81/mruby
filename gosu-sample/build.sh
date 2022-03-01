#!/bin/bash

emcc main.c \
    ../build/emscripten/lib/libmruby.a \
    -I../include \
    ../../gosu/emscripten-output/**/*.o \
    ../../gosu/emscripten-output/utf8proc.o \
    -sUSE_SDL=2 \
    -sLEGACY_GL_EMULATION=1 \
    -sASYNCIFY_STACK_SIZE=65536 \
    -O3 \
    -o index.html \
    --preload-file assets
