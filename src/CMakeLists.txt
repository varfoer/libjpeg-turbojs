

   include_directories("../extern/libjpeg-turbo" "../build/extern/libjpeg-turbo")

   set(libjpeg-turbo_DIR "/opt/libjpeg-turbo/lib32/cmake/libjpeg-turbo/")
   find_package(libjpeg-turbo)

   add_executable(libjpegturbojs jslib.cpp)

   target_link_libraries(libjpegturbojs turbojpeg)
   target_link_libraries(libjpegturbojs -L/opt/libjpeg-turbo/lib32/)
   
   target_compile_features(libjpegturbojs PUBLIC cxx_std_11)
   
   if (CMAKE_BUILD_TYPE STREQUAL Debug)
     SET(linkFlags "-g4")
   else() # Either MinSizeRel, RelWithDebInfo or Release, all which run with optimizations enabled.
     SET(linkFlags "-O3")
   endif()
   
   set(CMAKE_CXX_FLAGS_RELEASE "-O3 -fexceptions -msimd128")
   
   set_target_properties(
    libjpegturbojs 
       PROPERTIES 
       LINK_FLAGS "\
         --bind \
         -s MODULARIZE=1 \
         -s EXPORT_NAME=libjpegturbojs \
         -s WASM=0 \
         -s DISABLE_EXCEPTION_CATCHING=0 \
         -s ASSERTIONS=1 \
         -s NO_EXIT_RUNTIME=1 \
         -s MALLOC=emmalloc \
         -s TOTAL_MEMORY=1073741824 \
         -s FILESYSTEM=0 \
         -s EXPORTED_FUNCTIONS=[] \
         -s EXTRA_EXPORTED_RUNTIME_METHODS=[ccall] \
         -fexceptions \
      ")

   add_executable(libjpegturbowasm jslib.cpp)

   target_link_libraries(libjpegturbowasm turbojpeg)
   target_link_libraries(libjpegturbowasm -L/opt/libjpeg-turbo/lib32/)
   
   target_compile_features(libjpegturbowasm PUBLIC cxx_std_11)
   
   if (CMAKE_BUILD_TYPE STREQUAL Debug)
     SET(linkFlags "-g4")
   else() # Either MinSizeRel, RelWithDebInfo or Release, all which run with optimizations enabled.
     SET(linkFlags "-O3")
   endif()
   
   set(CMAKE_CXX_FLAGS_RELEASE "-O3 -fexceptions -msimd128")
   
   set_target_properties(
    libjpegturbowasm 
       PROPERTIES 
       LINK_FLAGS "\
         --bind \
         -s MODULARIZE=1 \
         -s EXPORT_NAME=libjpegturbowasm \
         -s DISABLE_EXCEPTION_CATCHING=0 \
         -s ASSERTIONS=1 \
         -s NO_EXIT_RUNTIME=1 \
         -s MALLOC=emmalloc \
         -s ALLOW_MEMORY_GROWTH=1 \
         -s TOTAL_MEMORY=1073741824 \
         -s FILESYSTEM=0 \
         -s EXPORTED_FUNCTIONS=[] \
         -s EXTRA_EXPORTED_RUNTIME_METHODS=[ccall] \
         -fexceptions \
      ")
   