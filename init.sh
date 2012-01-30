#!/bin/sh
echo ">> Cloning Vundle to bundle/vundle..."
git clone git://github.com/gmarik/vundle.git bundle/vundle

echo ">> Updating bundles..."
vim +BundleInstall +qall

echo ">> Done."
