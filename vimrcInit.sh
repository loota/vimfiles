#!/bin/sh
cd ~
git clone git://github.com/loota/vimfiles.git
mv ~/vimfiles ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
mkdir ~/.vimplugins

# Now either get each plugin with its repo/package or clone vimplugins with:
# cd ~/.vimplugins && git clone git://github.com/loota/vimplugins.git

# Remember to run from vim
# :call pathogen#helptags()
