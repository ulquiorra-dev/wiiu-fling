#~/bin/bash

echo Signing $1...
cd $(dirname "$1")
gpg --batch --detach-sign "$(basename $1)"
