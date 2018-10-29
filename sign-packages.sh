#~/bin/bash

rm -f *.sig *.sig*

for i in `find . -name '*.pkg*' -a ! -name '*.sig' -a ! -name '*.sig*'`; do
    echo Signing $i...
    gpg --batch --detach-sign $i
done
