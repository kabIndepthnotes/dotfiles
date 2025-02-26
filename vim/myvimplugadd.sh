" myvimplugadd.sh
#!/bin/bash
#NAME is what git uses internally
NAME=$1
#DEST is the name of the folder
DEST=$1
URL=$2
cd ${HOME}/docs/dotfiles/vim/pack/kab/opt/
git submodule add --name $NAME $URL $DEST
vim -u NONE -c "helptags $DEST/doc" -c q

