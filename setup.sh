#!/usr/bin/env bash

set -e

echo "脚本开始执行，日志将记录在 setup.log 文件中"
echo "======================================="
echo "开始执行脚本：$(date)" | tee -a setup.log
echo "======================================="

# 备份现有的 .zshrc（如果存在）
if [ -f "$HOME/.zshrc" ]; then
  echo "备份现有的 .zshrc 文件..." | tee -a setup.log
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)" | tee -a setup.log
fi

# xcode-tools
echo "正在检查和安装 Xcode Command Line Tools..." | tee -a setup.log
xcode-select --install || true 2>&1 | tee -a setup.log
echo "Xcode Command Line Tools 安装完成。" | tee -a setup.log
echo "======================================="

# oh my zsh
echo "正在安装 Oh My Zsh..." | tee -a setup.log
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>&1 | tee -a setup.log
echo "Oh My Zsh 安装完成。" | tee -a setup.log
echo "======================================="

# 复制项目中的 .zshrc 到用户主目录
echo "正在复制定制的 .zshrc 文件..." | tee -a setup.log
cp "$(dirname "$0")/.zshrc" "$HOME/.zshrc" | tee -a setup.log
echo ".zshrc 文件设置完成。" | tee -a setup.log

# install brew
echo "正在安装 Homebrew..." | tee -a setup.log
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 2>&1 | tee -a setup.log
echo "Homebrew 安装完成。" | tee -a setup.log
echo "======================================="

echo "正在配置 Homebrew环境变量..." | tee -a setup.log
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile" 2>&1 | tee -a setup.log
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "Homebrew环境变量配置完成。" | tee -a setup.log
echo "======================================="

# development tools
echo "正在安装 cli 开发工具..." | tee -a setup.log
/opt/homebrew/bin/brew install bufbuild/buf/buf 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install goenv 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install pyenv 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install uv 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install gh 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install vim 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install orbstack 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install helm 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install kubectx 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install kubectl 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install kube-ps1 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install rust 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install expect 2>&1 | tee -a setup.log
echo "开发工具安装完成。" | tee -a setup.log
echo "======================================="

# system
echo "正在安装系统工具和字体..." | tee -a setup.log
/opt/homebrew/bin/brew tap laishulu/homebrew 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install font-sarasa-nerd 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install gpg 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install openssl readline sqlite3 xz zlib tcl-tk@8 libb2 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install libffi 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install telnet 2>&1 | tee -a setup.log
echo "系统工具和字体安装完成。" | tee -a setup.log
echo "======================================="

# 定义 ZSH_CUSTOM 路径
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh plugins
echo "正在安装 Zsh 插件..." | tee -a setup.log
/opt/homebrew/bin/brew install autojump 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install zsh-autosuggestions 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install zsh-syntax-highlighting 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install powerlevel10k 2>&1 | tee -a setup.log
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" 2>&1 | tee -a setup.log
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM}/plugins/zsh-autocomplete" 2>&1 | tee -a setup.log
git clone https://github.com/paulirish/git-open.git "${ZSH_CUSTOM}/plugins/git-open" 2>&1 | tee -a setup.log
echo "Zsh 插件安装完成。" | tee -a setup.log

# nvm 安装
echo "安装 nvm..." | tee -a setup.log
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash 2>&1 | tee -a setup.log
echo "nvm 安装完成。" | tee -a setup.log

# jetbrains
echo "正在安装 Jetbrians 全家桶" | tee -a setup.log
/opt/homebrew/bin/brew install --cask jetbrains-toolbox 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install --cask goland 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install --cask pycharm 2>&1 | tee -a setup.log
/opt/homebrew/bin/brew install --cask webstorm 2>&1 | tee -a setup.log

# go
echo "正在安装 Go 相关工具..." | tee -a setup.log
/opt/homebrew/bin/brew install golangci-lint 2>&1 | tee -a setup.log

# 设置 goenv 环境变量
echo "配置 goenv 环境变量..." | tee -a setup.log
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
# 确保 goenv 可用
echo "验证 goenv 是否可用..." | tee -a setup.log
which goenv || { echo "goenv 未正确安装，请检查！" | tee -a setup.log; exit 1; }

# 安装 Go 版本
echo "安装 Go 版本..." | tee -a setup.log
goenv install 1.24 2>&1 | tee -a setup.log
goenv global 1.24 2>&1 | tee -a setup.log
goenv install 1.23 2>&1 | tee -a setup.log
goenv install 1.22 2>&1 | tee -a setup.log
goenv install 1.21 2>&1 | tee -a setup.log

# 其他配置文件
echo "复制 Git 设置..." | tee -a setup.log
cp "$(dirname "$0")/.gitconfig" "$HOME/.gitconfig"
cp "$(dirname "$0")/.gitignore" "$HOME/.gitignore"
echo "Git 配置完成。" | tee -a setup.log

echo "复制 Vim 配置..." | tee -a setup.log
cp "$(dirname "$0")/.vimrc" "$HOME/.vimrc"
echo "Vim 配置完成。" | tee -a setup.log

echo "======================================="
echo "脚本执行结束：$(date)" | tee -a setup.log
echo "======================================="

echo "安装完成！请注意："
echo "1. 执行 'source ~/.zshrc' 或重启终端使配置生效"
echo "2. 运行 'p10k configure' 配置 Powerlevel10k 主题"
echo "3. 运行 'rustup-init' 完成 Rust 安装设置"
echo "4. 请检查 setup.log 文件以获取详细的安装日志"
