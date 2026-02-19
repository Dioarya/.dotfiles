#!/usr/bin/bash
# REMEMBER TO USE THIS, RAWR
pushd $DOTFILES
pushd personal
git add .
git commit -m "autocommit personal dotfiles" --no-gpg-sign
git push origin master
popd
git add .
git commit -m "autocommit dotfiles" --no-gpg-sign
git push origin master
popd
