#!/bin/bash

#Make our output directory (pages)
mkdir -p $CI_PROJECT_DIR/public/packages

# For each package
for i in `find $CI_PROJECT_DIR/packages/*/ -name '*.pkg*' -a ! -name '*.sig'`; do
    # strip off project dir path (i.e. /packages/*/)
    pkgpath=$(dirname "$i")
    pkgrelpath=${pkgpath#"$CI_PROJECT_DIR"}
    echo $CI_PROJECT_DIR/public/$pkgrelpath
    # make that directory
    mkdir -p $CI_PROJECT_DIR/public/$pkgrelpath
    
    # Copy the package
    cp $i $CI_PROJECT_DIR/public/$pkgrelpath
done

repo-add $CI_PROJECT_DIR/public/wiiu-fling-staging.db.tar.gz `find $CI_PROJECT_DIR/public/packages/*/ -name '*.pkg*' -a ! -name '*.sig'`
