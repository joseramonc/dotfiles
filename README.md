# @joseramonc dotfiles

My .dotfiles, forked from [holman dotfiles](https://github.com/holman/dotfiles), much :heart:

# install

Run this:

    git clone https://github.com/joseramonc/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    script/bootstrap
This will symlink the appropriate files in .dotfiles to your home directory. Everything is configured and tweaked within ~/.dotfiles.

The main file you'll want to change right off the bat is zsh/zshrc.symlink, which sets up a few paths that'll be different on your particular machine.

Also you may want to check [osx defaults](https://github.com/joseramonc/dotfiles/tree/master/osx) before setting them up. 

dot is a simple script that installs some dependencies, sets sane OS X defaults, and so on. Tweak this script, and occasionally run dot from time to time to keep your environment fresh and up-to-date. You can find this script in bin/.
