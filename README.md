# Create libclang-all.so.8

The bash script, make-clang-all.sh, `cd BUILD_DIR` and creates
lib/libclang-all.so.8 and copies it to the INSTALL_DIR.

Executing make-clang-all.sh without parameters shows help.
```:
$ ./make-clang-all.sh
./make-clang-all.sh: INSTALL_DIR [BUILD_DIR]
Assumes libclang\*.a libraries have been built doing something like:
   cmake .. -DCMAKE_INSTALL_PREFIX=/home/wink/local -DCMAKE_PREFIX_PATH=/home/wink/local -DCMAKE_BUILD_TYPE=Release
See https://github.com/ziglang/zig/wiki/How-to-build-LLVM,-libclang,-and-liblld-from-source#posix

 INSTALL_DIR    Required first parameter same as CMAKE_INSTALL_PREFIX
 BUILD_DIR      Optional second parameter, '.' if empty
```

## Example:
```
$ ./make-clang-all.sh ~/local ../cfe-8.0.0.src.make.clang-all/build/
+ cd ../cfe-8.0.0.src.make.clang-all/build/
+ c++ -fPIC -fPIC -fvisibility-inlines-hidden -Werror=date-time -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wno-missing-field-initializers -Wimplicit-fallthrough -Wno-class-memaccess -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wno-comment -fdiagnostics-color -ffunction-sections -fdata-sections -fno-common -Woverloaded-virtual -fno-strict-aliasing -pedantic -Wno-long-long -O3 -DNDEBUG -Wl,-z,defs -Wl,-z,nodelete -Wl,-rpath-link,/home/wink/prgs/llvm/cfe-8.0.0.src/build/./lib -Wl,-O3 -Wl,--gc-sections -shared -Wl,-soname,libclang.so.8 -o lib/libclang-all.so.8 tools/libclang/CMakeFiles/libclang.dir/ARCMigrate.cpp.o tools/libclang/CMakeFiles/libclang.dir/BuildSystem.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndex.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexCXX.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexCodeCompletion.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexDiagnostic.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexHigh.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexInclusionStack.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexUSRs.cpp.o tools/libclang/CMakeFiles/libclang.dir/CIndexer.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXComment.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXCursor.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXIndexDataConsumer.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXCompilationDatabase.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXLoadedDiagnostic.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXSourceLocation.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXStoredDiagnostic.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXString.cpp.o tools/libclang/CMakeFiles/libclang.dir/CXType.cpp.o tools/libclang/CMakeFiles/libclang.dir/Indexing.cpp.o -Wl,--whole-archive lib/libclangCodeGen.a lib/libclangFrontendTool.a lib/libclangRewriteFrontend.a lib/libclangStaticAnalyzerFrontend.a lib/libclangFrontend.a -Wl,--no-whole-archive -L/home/wink/local/lib '-Wl,-rpath,$ORIGIN/../lib' lib/libclangAST.a lib/libclangBasic.a lib/libclangFrontend.a lib/libclangIndex.a lib/libclangLex.a lib/libclangSema.a lib/libclangSerialization.a lib/libclangTooling.a lib/libclangARCMigrate.a -ldl lib/libclangStaticAnalyzerCheckers.a lib/libclangStaticAnalyzerCore.a lib/libclangCrossTU.a lib/libclangIndex.a lib/libclangFrontend.a lib/libclangDriver.a lib/libclangParse.a lib/libclangSerialization.a lib/libclangSema.a lib/libclangEdit.a lib/libclangAnalysis.a lib/libclangASTMatchers.a lib/libclangFormat.a lib/libclangToolingInclusions.a lib/libclangToolingCore.a lib/libclangAST.a lib/libclangRewrite.a lib/libclangLex.a lib/libclangBasic.a /home/wink/local/lib/libLLVM-8.so
+ cp lib/libclang-all.so.8 /home/wink/local/lib/libclang-all.so.8
+ ln -sf /home/wink/local/lib/libclang-all.so.8 /home/wink/local/lib/libclang-all.so
```
