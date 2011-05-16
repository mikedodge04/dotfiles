#!/bin/bash

TARGET=`cd ${TARGET-$HOME}; pwd`
SOURCE=`cd $(dirname "$0")/files; pwd`

# Special case for permissions
mkdir $TARGET/.ssh 2>/dev/null && chmod 700 $TARGET/.ssh
cd $SOURCE
(find . -maxdepth 1 -type f ; find ./*/ -mindepth 1 -maxdepth 1) | while read i; do
  [[ "$i" == "." ]] && continue
  i=${i:2}
  fullpath="`cd $(dirname "$i"); pwd`/$(basename "$i")"
  mkdir -p "$TARGET/.$(dirname "$i")"
  rm -i "$TARGET/.$i" </dev/tty
  ln -s "$fullpath" "$TARGET/.$i"
done
# A special case
mkdir -p $TARGET/.vim/swaps

echo "Done. Don't forget to source ~/.bashrc"
