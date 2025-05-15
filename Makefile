default:
	echo "hello world"

symlink-vim: lit-vim
	ln -s /home/kab/docs/dotfiles/vim /home/kab/.config/vim

symlink-qute-configpy:
	ln -s ~/docs/dotfiles/qutebrowser/config.py ~/.config/qutebrowser/config.py

symlink-bashrc:
	ln -s /home/kab/docs/dotfiles/dot-bashrc /home/kab/.bashrc

lit-vim: lit-ultisnip
	lit --tangle lits/vimrc.lit --out-dir vim/
	lit --weave lits/vimrc.lit  --out-dir docs/
	# lit --weave lits/vimrc.lit --md-compiler --out-dir docs/
	mv vim/vimrc.vim vim/vimrc # annoying rule of lit
	sed -i 1d vim/myvimplugadd.sh # remove first line comment
	sed -i 1d vim/myvimplugupdate.sh # remove first line comment


lit-ultisnip:
	lit --tangle lits/ultisnips.lit --out-dir vim/UltiSnips/
	lit --weave lits/ultisnips.lit --out-dir docs/

symlink-taskrc:
	ln -s /home/kab/docs/dotfiles/dot-taskrc /home/kab/.config/task/taskrc
