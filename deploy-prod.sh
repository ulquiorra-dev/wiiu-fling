#!/bin/bash

#Make our output directory (pages)
mkdir -p $CI_PROJECT_DIR/public/packages

#Copy in public key
cp $CI_PROJECT_DIR/fling-key.pub $CI_PROJECT_DIR/public/

# For each package
for i in `find $CI_PROJECT_DIR/packages/*/ -name '*.pkg*' -a ! -name '*.sig'`; do
    # strip off project dir path (i.e. /packages/*/)
    pkgpath=$(dirname "$i")
    pkgrelpath=${pkgpath#"$CI_PROJECT_DIR"}
    echo $CI_PROJECT_DIR/public/$pkgrelpath
    # make that directory
    mkdir -p $CI_PROJECT_DIR/public/$pkgrelpath

    # If it's signed, copy it out
    if [ -f $i.sig ]; then
        cp $i{,.sig} $CI_PROJECT_DIR/public/$pkgrelpath
    # Otherwise, copy and sign
    else
        cp $i $CI_PROJECT_DIR/public/$pkgrelpath
        $CI_PROJECT_DIR/sign-package.sh $CI_PROJECT_DIR/public/$pkgrelpath/*.pkg*
    fi
done

cd $CI_PROJECT_DIR/public && tar cvJf packages.tar.xz packages/

#just for debug
cd $CI_PROJECT_DIR/public/ && find packages/*/ -name '*.pkg*' -a ! -name '*.sig'

#make the database
cd $CI_PROJECT_DIR/public/ && repo-add --sign wiiu-fling.db.tar.gz `find packages/*/ -name '*.pkg*' -a ! -name '*.sig'`
