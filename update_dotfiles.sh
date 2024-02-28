#!/bin/bash

dot_conf=$HOME/.config
echo $dot_conf
cp $dot_conf/git $HOME/dotfiles -r
cp $dot_conf/sway $HOME/dotfiles -r
