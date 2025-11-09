#!/bin/zsh
# aliases.zsh - 常用别名

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
alias reload='source ~/.zshrc'
alias zshconfig='${EDITOR:-vim} ~/.zshrc'

# 文件操作 (安全模式)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dlog='docker logs -f'

# 网络
alias ports='netstat -tulanp'
alias myip='curl ipinfo.io/ip'

# 快速编辑
alias hosts='sudo ${EDITOR:-vim} /etc/hosts'
