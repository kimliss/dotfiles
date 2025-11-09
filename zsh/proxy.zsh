#!/bin/zsh
# 代理配置

PROXY_HOST="127.0.0.1"
PROXY_PORT="7890"
PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"

proxy_on() {
    export http_proxy="${PROXY_URL}"
    export https_proxy="${PROXY_URL}"
    export all_proxy="${PROXY_URL}"
    export HTTP_PROXY="${PROXY_URL}"
    export HTTPS_PROXY="${PROXY_URL}"
    export ALL_PROXY="${PROXY_URL}"
    
    git config --global http.proxy "${PROXY_URL}"
    git config --global https.proxy "${PROXY_URL}"
    
    echo "✅ 代理已开启: ${PROXY_URL}"
}

proxy_off() {
    unset http_proxy https_proxy all_proxy
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    
    echo "❌ 代理已关闭"
}

proxy_status() {
    if [[ -n "$http_proxy" ]]; then
        echo "🟢 代理状态: 已开启"
        echo "HTTP Proxy: $http_proxy"
        echo "HTTPS Proxy: $https_proxy"
        echo "Git Proxy: $(git config --global http.proxy)"
    else
        echo "🔴 代理状态: 已关闭"
    fi
}

proxy_test() {
    if [[ -n "$http_proxy" ]]; then
        echo "正在测试代理连接..."
        if curl -I -s --connect-timeout 5 https://www.google.com > /dev/null; then
            echo "✅ 代理连接成功"
        else
            echo "❌ 代理连接失败"
        fi
    else
        echo "⚠️  代理未开启"
    fi
}

alias pon='proxy_on'
alias poff='proxy_off'
alias pst='proxy_status'
alias ptest='proxy_test'
