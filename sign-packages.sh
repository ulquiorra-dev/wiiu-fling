for i in *.pkg*; do
    echo Signing $i...
    gpg --batch --detach-sign $i
; done
