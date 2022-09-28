include_directories(..)

# Runtime library sources and build flags.
set(HEXTYPE_SOURCES
  hextype.cc
  hextype_report.cc
  hextype_rbtree.cc
  )

set(HEXTYPE_HEADERS
  hextype.h
  hextype_report.h
  hextype_rbtree.h
  )

set(HEXTYPE_CFLAGS ${SANITIZER_COMMON_CFLAGS})

append_rtti_flag(OFF HEXTYPE_CFLAGS)

# Prevent clang from generating libc calls.
append_list_if(COMPILER_RT_HAS_FFREESTANDING_FLAG -ffreestanding HEXTYPE_CFLAGS)

set(HEXTYPE_RUNTIME_LIBRARIES)

# Static runtime library.
add_compiler_rt_component(hextype)

add_compiler_rt_runtime(clang_rt.hextype
	STATIC
	ARCHS x86_64
	SOURCES ${HEXTYPE_SOURCES}
	CFLAGS ${HEXTYPE_CFLAGS}
	PARENT_TARGET hextype)

add_sanitizer_rt_symbols(clang_rt.hextype)
add_dependencies(compiler-rt hextype)

