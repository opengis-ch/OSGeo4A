#!/bin/bash


# version of your package
VERSION_openjpeg=2.4.0

# dependencies of this recipe
DEPS_openjpeg=()

# url of the package
URL_openjpeg=https://github.com/uclouvain/openjpeg/archive/v${VERSION_openjpeg}.tar.gz

# default recipe path
RECIPE_openjpeg=$RECIPES_PATH/openjpeg

# default build path
BUILD_openjpeg=$BUILD_PATH/openjpeg/$(get_directory $URL_openjpeg)

# function called for preparing source code if needed
function prebuild_openjpeg() {
  touch .patched
}

function shouldbuild_openjpeg() {
  # If lib is newer than the sourcecode skip build
  if [ $BUILD_PATH/openjpeg/build-$ARCH/libjpeg.so -nt $BUILD_openjpeg/.patched ]; then
    DO_BUILD=0
  fi
}

# function called to build the source code
function build_openjpeg() {
  try mkdir -p $BUILD_PATH/openjpeg/build-$ARCH
  try cd $BUILD_PATH/openjpeg/build-$ARCH
  push_arm
#    -DANDROID_STL=gnustl_shared \
  try $CMAKECMD \
    -DCMAKE_INSTALL_PREFIX:PATH=$STAGE_PATH \
    $BUILD_openjpeg
  try $MAKESMP
  try $MAKESMP install
  pop_arm
}

# function called after all the compile have been done
function postbuild_openjpeg() {
  true
}
