default:
	echo "hello world"

symlink-vim: lit-vim
	ln -s /home/kab/docs/dotfiles/vim /home/kab/.config/vim

symlink-bashrc:
	ln -s /home/kab/docs/dotfiles/dot-bashrc /home/kab/.bashrc

lit-vim:
	lit --tangle lits/vimrc.lit --out-dir vim/
	lit --weave lits/vimrc.lit --out-dir docs/
	mv vim/vimrc.vim vim/vimrc # annoying rule of lit
	sed -i 1d vim/myvimplugadd.sh # remove first line comment
	sed -i 1d vim/myvimplugupdate.sh # remove first line comment

