LLVM_DIR = ${CURDIR}/llvm-14.0.5.src
BUILD_DIR = ${CURDIR}/build
#-DLLVM_TARGETS_TO_BUILD="X86;RISCV" 
hextype:
	mkdir -p ${BUILD_DIR}
	(cd ${BUILD_DIR} && \
	  cmake \
	  -DCMAKE_C_COMPILER=clang \
	  -DCMAKE_CXX_COMPILER=clang++ \
	  -DLLVM_ENABLE_ASSERTIONS=ON \
	  -DLLVM_BUILD_TESTS=ON \
	  -DLLVM_BUILD_EXAMPLES=ON \
	  -DLLVM_INCLUDE_TESTS=ON \
	  -DLLVM_INCLUDE_EXAMPLES=ON \
	  -DBUILD_SHARED_LIBS=on \
	  -DLLVM_TARGETS_TO_BUILD="X86;WebAssembly;" \
	  -DCMAKE_C_FLAGS+="-fstandalone-debug" \
	  -DCMAKE_CXX_FLAGS="-fstandalone-debug" \
	  ${LLVM_DIR})
	(cd ${BUILD_DIR} && make -j`nproc`)
clean:
	rm -rf ${BUILD_DIR}

.PHONY: hextype clean

