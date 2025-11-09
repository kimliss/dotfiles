#!/bin/zsh
# 常用别名

# 目录导航
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# ls 增强
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Git 快捷命令
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# 系统
alias c='clear'
alias h='history'
alias ports='netstat -tulanp'

# 文件操作
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Docker (如果使用)
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# 其他
alias reload='source ~/.zshrc'
alias zshconfig='vim ~/.zshrc'
