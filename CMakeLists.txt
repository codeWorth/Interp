cmake_minimum_required(VERSION 4.0.3)

project(Interp 
    VERSION 0.1
    LANGUAGES C)

add_executable(Interp interp.c)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_C_FLAGS "-march=native")
