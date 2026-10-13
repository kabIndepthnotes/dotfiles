.PHONY: default install clean lit-vim lit-ultisnip
default:install

clean:rm-symlink-vim rm-symlink-lf rm-symlink-newsboat rm-symlink-zshrc # rm-symlink-taskrc

install:symlink-vim symlink-lf symlink-newsboat symlink-zshrc # symlink-taskrc

rm-symlink-vim:
	rm $(HOME)/.config/vim

rm-symlink-lf:
	[ -L $(HOME)/.config/lf/lfrc ] && rm $(HOME)/.config/lf/lfrc || true

rm-symlink-zshrc:
	[ -L $(HOME)/.zshrc ] && rm $(HOME)/.zshrc || true

rm-symlink-newsboat:
	[ -L $(HOME)/.newsboat/config ] && rm $(HOME)/.newsboat/config || true

rm-symlink-taskrc:
	[ -L $(HOME)/.config/task/taskrc ] && rm $(HOME)/.config/task/taskrc || true

symlink-vim:
	ln -sfn $(CURDIR)/vim $(HOME)/.config/vim

symlink-lf:
	ln -sfn $(CURDIR)/lfrc $(HOME)/.config/lf/lfrc

symlink-zshrc:
	ln -sfn $(CURDIR)/dot-zshrc $(HOME)/.zshrc

symlink-newsboat:
	ln -sfn $(CURDIR)/newsboatrc $(HOME)/.newsboat/config

symlink-taskrc:
	ln -sfn $(CURDIR)/dot-taskrc $(HOME)/.config/task/taskrc

# symlink-scim:
# 	# mkdir $(CURDIR)/sc-im
# 	ln -sfn $(CURDIR)/scimrc $(HOME)/.config/sc-im/scimrc

# symlink-qute-configpy:
# 	ln -sfn ~/docs/qutebrowser/config.py ~/.config/qutebrowser/config.py

# symlink-bashrc:
# 	ln -sfn $(CURDIR)/dot-bashrc $(HOME)/.bashrc
#

lit-vim: lits/vimrc.lit
	lit --tangle $< --out-dir vim/
	lit --weave  $<  --out-dir docs/
	mv vim/vimrc.vim vim/vimrc # annoying rule of lit
	mv vim/syntax/csound_opcodes.vim vim/syntax/csound_opcodes # annoying rule of lit
	# sed -i 1d vim/myvimplugadd.sh # remove first line comment, just use noHeader
	# sed -i 1d vim/myvimplugupdate.sh # remove first line comment, just use noHeader

lit-ultisnip: lits/ultisnips.lit
	lit --tangle $< --out-dir vim/UltiSnips/
	lit --weave  $< --out-dir docs/

