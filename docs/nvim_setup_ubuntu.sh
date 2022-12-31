#!/bin/bash
set -exu
set -o pipefail

echo "Installing Python packages"
declare -a PY_PACKAGES=("pynvim" 'python-lsp-server[all]' "black" "vim-vint" "pyls-isort" "pylsp-mypy")

echo "Using system Python to install $(PY_PACKAGES)"

# If we use system Python, we need to install these Python packages under
# user HOME, since we do not have permissions to install them under system
# directories.
for p in "${PY_PACKAGES[@]}"; do
  pip install --user "$p"
done

sudo apt install  universal-ctags ripgrep
NVIM_LINK="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb"
NVIM_CONFIG_DIR=$HOME/.config/nvim
wget "$NVIM_LINK" -O /tmp/nvim-linux64.deb
sudo apt install /tmp/nvim-linux64.deb

echo "Setting up config and installing plugins"
if [[ -d "$NVIM_CONFIG_DIR" ]]; then
    rm -rf "$NVIM_CONFIG_DIR.backup"
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup"
fi

git clone --depth=1 git@github.com:linh-nguyen-scaleaq/nvim-config.git "$NVIM_CONFIG_DIR"

echo "Installing packer.nvim"
if [[ ! -d ~/.local/share/nvim/site/pack/packer/opt/packer.nvim ]]; then
    git clone --depth=1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
fi

echo "Installing nvim plugins, please wait"
nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"

echo "Finished installing Nvim and its dependencies!"
