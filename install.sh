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
cmake \
ccls \
universal-ctags \
build-essential \
binutils \
clang \
libsdl2-dev \
libsdl2-image-dev \
imagemagick \
openvpn \
openconnect \
network-manger-openvpn \
network-manger-openconnect \
network-manger-openvpn-gnome \
network-manger-openconnect-gnome \
kdeconnect \
ripgrep \
fd-find \
neofetch

sudo usermod -aG docker $(whoami)

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
git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

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
pip install pynvim jedi
pip3 install pynvim jedi
gem install neovim
sudo npm i -g neovim bash-language-server
nvim +PlugInstall +qall
nvim -c 'CocInstall -sync coc-json coc-tsserver coc-prettier coc-eslint coc-snippets coc-css coc-gocode coc-rls coc-tslint-plugin coc-vetur coc-python coc-phpls|q'
ln -s .dotfiles/coc-settings.json $HOME/.config/nvim/.

echo "Git"
rm -rf .gitconfig .gitignore
ln -s .dotfiles/gitconfig .gitconfig
ln -s .dotfiles/gitignore .gitignore
git config --global core.excludesfile '$HOME/.gitignore'

echo "JS"
sudo npm i -g typescript tslint eslint prettier

# Installing base16 theme
echo "Installing base16 theme"
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
eval "base16_tomorrow-night"

echo "Rust"
curl https://sh.rustup.rs -sSf | sh

echo "Z"
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O $HOME/.z

echo "Ranger"
[ ! -d .config/ranger ] && mkdir .config/ranger
ranger --copy-config=all
echo "source $HOME/.dotfiles/ranger/rc.conf" >> .config/ranger/rc.conf
