#
# Environment setup metascript for arm64 Android kernel builds with Clang
# Copyright (C) 2019-2020 Danny Lin <danny@kdrag0n.dev>
#
# This script must be *sourced* from a Bourne-compatible shell in order to
# function. Nothing will happen if you execute it.
#

# Path to toolchains
clang_bin="/mnt/ssd0/toolchains/clang/clang-r450784d/bin"
gcc_arm64="/mnt/ssd0/toolchains/gcc/aarch64-linux-android-4.9/bin"
gcc_arm32="/mnt/ssd0/toolchains/gcc/arm-linux-androideabi-4.9/bin"

# 64-bit GCC toolchain prefix
gcc_prefix64="aarch64-linux-android-"

# 32-bit GCC toolchain prefix
gcc_prefix32="arm-linux-androideabi-"

# Number of parallel jobs to run
# Do not remove; set to 1 for no parallelism.
jobs=$(nproc)

# Do not edit below this point
# ----------------------------

# Load the shared helpers
source helpers.sh

_ksetup_old_path="$PATH"
export PATH="$clang_bin:$gcc_arm64:$gcc_arm32:$PATH"

# Index of variables for cleanup in unsetup
_ksetup_vars+=(
	clang_bin
	gcc_arm64
	gcc_arm32
	gcc_prefix64
	gcc_prefix32
	jobs
	kmake_flags
)

kmake_flags+=(
	CC="clang"
	CLANG_TRIPLE="aarch64-linux-gnu-"

	CROSS_COMPILE="$gcc_prefix64"
	CROSS_COMPILE_ARM32="$gcc_prefix32"

	KBUILD_COMPILER_STRING="$(get_clang_version clang)"
)
