#! /bin/sh

git clone git@github.com:gabrielelanaro/emacs-for-python.git
git clone https://github.com/winterTTr/ace-jump-mode

wget https://raw.githubusercontent.com/dkogan/xcscope.el/master/xcscope.el
wget http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz
tar -zxvf color-theme-6.6.0.tar.gz
mv xcscope.el lisp/
