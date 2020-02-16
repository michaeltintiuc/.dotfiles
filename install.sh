# Install packages
echo "Installing packages..."
sudo apt-get update
sudo apt-get install -y \
neovim \
docker \
docker-compose \
golang \
kitty \
zsh \
zsh-autosuggestions \
ranger \
fzf \
npm \
composer \
ruby \
python-pip \
python3-pip \
cmake

# Setting zsh as default shell
echo "Setting up zsh as default shell"
chsh -s $(which zsh)

# Setting up environment files
echo "Setting up environment files"
cd $HOME

echo "ZSH"
[ -f .zshrc ] && cp .zshrc .zshrc.bak
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "source $HOME/.dotfiles/zsh/zshrc" >> .zshrc
git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH/plugins/fast-syntax-highlighting

echo "BASH"
[ -f .bashrc ] && cp .bashrc .bashrc.bak
echo "source $HOME/.dotfiles/bash/bashrc" >> .bashrc

echo "Kitty"
[ ! -d .config/kitty ] && mkdir .config/kitty
echo "include $HOME/.dotfiles/kitty.conf" >> .config/kitty/kitty.conf

echo "NPM"
[ ! -d .npm-packages ] && mkdir .npm-packages
sudo npm i -g npm

echo "NeoVim"
[ ! -d .config/nvim ] && mkdir .config/nvim
echo "source $HOME/.dotfiles/init.vim" >> .config/nvim/init.vim
pip install pynvim
pip3 install pynvim
gem install neovim
sudo npm i -g neovim

echo "Git"
rm -rf .gitconfig .gitignore
ln -s .dotfiles/gitconfig .gitconfig
ln -s .dotfiles/gitignore .gitignore

echo "JS"
sudo npm i -g typescript tslint eslint

# Installing base16 theme
echo "Installing base16 theme"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
eval "base16_tomorrow-night"
