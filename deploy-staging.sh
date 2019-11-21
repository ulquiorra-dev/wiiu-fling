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

cd $CI_PROJECT_DIR/public/ && tar cvJf packages.tar.xz packages/

#move everything to the root directory and remove the nested stuff
cd $CI_PROJECT_DIR/public/ && cp -v packages/*/*.pkg* . && rm -rf packages/

#just for debug
cd $CI_PROJECT_DIR/public/ && ls -al

#make the database
cd $CI_PROJECT_DIR/public/ && repo-add --sign wiiu-fling-staging.db.tar.gz `find . -name '*.pkg*' -a ! -name '*.sig'`
