default:
	echo "hello world"

vim-symlink: lit-vim
	ln -s /home/kab/docs/dotfiles/vim /home/kab/.config/vim


lit-vim:
	lit --tangle lits/vimrc.lit --out-dir vim/
	lit --weave lits/vimrc.lit --out-dir docs/
	mv vim/vimrc.vim vim/vimrc #annoying rule of lit

