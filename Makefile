# Build libclang-all.so.8

ifneq (help,$(MAKECMDGOALS))
  ifeq (,$(INSTALL_DIR))
    $(error "Missing INSTALL_DIR, use `make help`")
  endif
endif

BUILD_DIR ?= .
LIB_LLVM_DIR ?= $(BUILD_DIR)
OBJ_PREFIX :=

ifneq (, $(INSTALL_DIR))
  override INSTALL_DIR := $(abspath $(INSTALL_DIR))
endif

ifneq (, $(BUILD_DIR))
  override BUILD_DIR := $(abspath $(BUILD_DIR))
endif

LIBS := \
    $(BUILD_DIR)/lib/libclangCodeGen.a \
    $(BUILD_DIR)/lib/libclangFrontendTool.a \
    $(BUILD_DIR)/lib/libclangRewriteFrontend.a \
    $(BUILD_DIR)/lib/libclangStaticAnalyzerFrontend.a \
    $(BUILD_DIR)/lib/libclangAST.a \
    $(BUILD_DIR)/lib/libclangBasic.a \
    $(BUILD_DIR)/lib/libclangFrontend.a \
    $(BUILD_DIR)/lib/libclangIndex.a \
    $(BUILD_DIR)/lib/libclangLex.a \
    $(BUILD_DIR)/lib/libclangSema.a \
    $(BUILD_DIR)/lib/libclangSerialization.a \
    $(BUILD_DIR)/lib/libclangTooling.a \
    $(BUILD_DIR)/lib/libclangARCMigrate.a \
    $(BUILD_DIR)/lib/libclangStaticAnalyzerCheckers.a \
    $(BUILD_DIR)/lib/libclangStaticAnalyzerCore.a \
    $(BUILD_DIR)/lib/libclangCrossTU.a \
    $(BUILD_DIR)/lib/libclangDriver.a \
    $(BUILD_DIR)/lib/libclangParse.a \
    $(BUILD_DIR)/lib/libclangEdit.a \
    $(BUILD_DIR)/lib/libclangAnalysis.a \
    $(BUILD_DIR)/lib/libclangASTMatchers.a \
    $(BUILD_DIR)/lib/libclangFormat.a \
    $(BUILD_DIR)/lib/libclangToolingInclusions.a \
    $(BUILD_DIR)/lib/libclangToolingCore.a \
    $(BUILD_DIR)/lib/libclangRewrite.a \
    $(BUILD_DIR)/lib/libclangToolingASTDiff.a \
    $(BUILD_DIR)/lib/libclangToolingRefactor.a \
    $(BUILD_DIR)/lib/libclangDynamicASTMatchers.a \
    $(BUILD_DIR)/lib/libclangHandleCXX.a \

# Adding below:
#    $(BUILD_DIR)/lib/libclangHandleLLVM.a \
# Fails with:
#   CommandLine Error: Option 'asm-instrumentation' registered more than once!

## libclang*.a from cfe-.0.0.src (All but the last two are in $(LIBS)
#libclangAnalysis.a
#libclangARCMigrate.a
#libclangAST.a
#libclangASTMatchers.a
#libclangBasic.a
#libclangCodeGen.a
#libclangCrossTU.a
#libclangDriver.a
#libclangEdit.a
#libclangFormat.a
#libclangFrontend.a
#libclangFrontendTool.a
#libclangIndex.a
#libclangLex.a
#libclangParse.a
#libclangRewrite.a
#libclangRewriteFrontend.a
#libclangSema.a
#libclangSerialization.a
#libclangStaticAnalyzerCheckers.a
#libclangStaticAnalyzerCore.a
#libclangStaticAnalyzerFrontend.a
#libclangTooling.a
#libclangToolingCore.a
#libclangToolingInclusions.a
#libclangToolingASTDiff.a
#libclangToolingRefactor.a
#libclangDynamicASTMatchers.a
#libclangHandleCXX.a
# libclangHandleLLVM.a

## libclang*.a from llvm/llvm-project
#libclangAnalysis.a
#libclangARCMigrate.a
#libclangASTMatchers.a
#libclangBasic.a
#libclangCodeGen.a
#libclangCrossTU.a
#libclangDriver.a
#libclangDynamicASTMatchers.a
#libclangEdit.a
#libclangFormat.a
#libclangFrontend.a
#libclangFrontendTool.a
#libclangHandleCXX.a
#libclangHandleLLVM.a
#libclangIndex.a
#libclangLex.a
#libclangParse.a
#libclangRewrite.a
#libclangRewriteFrontend.a
#libclangSema.a
#libclangSerialization.a
#libclangStaticAnalyzerCheckers.a
#libclangStaticAnalyzerCore.a
#libclangStaticAnalyzerFrontend.a
#libclangTooling.a
#libclangToolingASTDiff.a
#libclangToolingCore.a
#libclangToolingInclusions.a
#libclangToolingRefactor.a
#libclangAST.a
# libclangApplyReplacements.a
# libclangChangeNamespace.a
# libclangDaemon.a
# libclangDoc.a
# libclangIncludeFixer.a
# libclangIncludeFixerPlugin.a
# libclangMove.a
# libclangQuery.a
# libclangReorderFields.a
# libclangTidy.a
# libclangTidyAbseilModule.a
# libclangTidyAndroidModule.a
# libclangTidyBoostModule.a
# libclangTidyBugproneModule.a
# libclangTidyCERTModule.a
# libclangTidyCppCoreGuidelinesModule.a
# libclangTidyFuchsiaModule.a
# libclangTidyGoogleModule.a
# libclangTidyHICPPModule.a
# libclangTidyLLVMModule.a
# libclangTidyMiscModule.a
# libclangTidyModernizeModule.a
# libclangTidyMPIModule.a
# libclangTidyObjCModule.a
# libclangTidyPerformanceModule.a
# libclangTidyPlugin.a
# libclangTidyPortabilityModule.a
# libclangTidyReadabilityModule.a
# libclangTidyUtils.a
# libclangTidyZirconModule.a

CC := c++

COMPILER_FLAGS := \
    -fPIC -fPIC -fvisibility-inlines-hidden -Werror=date-time -std=c++11 -Wall -Wextra -Wno-unused-parameter \
    -Wwrite-strings -Wcast-qual -Wno-missing-field-initializers -Wimplicit-fallthrough -Wno-class-memaccess \
    -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wno-comment -fdiagnostics-color -ffunction-sections -fdata-sections \
    -fno-common -Woverloaded-virtual -fno-strict-aliasing -pedantic -Wno-long-long -O3 -DNDEBUG \

LINKER_FLAGS := \
    -Wl,-z,defs -Wl,-z,nodelete -Wl,-rpath-link,$($BUILD_DIR)/lib -Wl,-rpath,"$$ORIGIN/../lib" \
    -Wl,-O3 -Wl,--gc-sections -Wl,-soname,libclang-all.so.8 \

$(warning BUILD_DIR="$(BUILD_DIR)")
$(warning INSTALL_DIR="$(INSTALL_DIR)")
$(warning OBJ_PREFIX="$(OBJ_PREFIX)")
$(warning LIB_LLVM_DIR="$(LIB_LLVM_DIR)")

.PHONY: all
all: $(INSTALL_DIR)/lib/libclang-all.so.8

.PHONY: $(INSTALL_DIR)/lib/libclang-all.so.8
$(INSTALL_DIR)/lib/libclang-all.so.8:
	cd ${BUILD_DIR} && \
	${CC} ${CLFAGS} -shared -o $@ -Wl,--whole-archive ${LIBS} -Wl,--no-whole-archive \
	-Llib \
	-ldl \
	${LIB_LLVM_DIR}/lib/libLLVM-8.so && \
	ln -sf $@ ${INSTALL_DIR}/lib/libclang-all.so

.PHONY: clean
clean:
	@rm -f ${INSTALL_DIR}/lib/libclang-all.so.8 ${INSTALL_DIR}/lib/libclang-all.so

.PHONY: help
help:
	@echo "Builds libclang-all.so.8 and installs it at \$$INSTALL_DIR/lib"
	@echo "Assumes libclang*.a libraries have been built doing something like:"
	@echo "   cmake .. -DCMAKE_INSTALL_PREFIX=\$$HOME/local -DCMAKE_PREFIX_PATH=\$$HOME/local -DCMAKE_BUILD_TYPE=Release"
	@echo "See https://github.com/ziglang/zig/wiki/How-to-build-LLVM,-libclang,-and-liblld-from-source#posix"
	@echo
	@echo "Goals:"
	@echo "  all		        Make libclang-all, default goal if not present"
	@echo "  help		        This help message"
	@echo
	@echo "parameters:"
	@echo "  INSTALL_DIR=<dir>      Directory where lib/libclang-all.so is to be installed, required"
	@echo "  BUILD_DIR=<dir>        Directory where clang was built, default \".\""
	@echo "  LIB_LLVM_DIR=<dir>     Directory where lib/libLLVM-8.so resides, default \$$(BUILD_DIR)"
	@echo "  OBJ_PREFIX=<dir>       Objects are assumed to be at \$$(BUILD_DIR)/\$$(OBJ_PREFIX)/tools/libclang/CMakeFiles/libclang.dir"

