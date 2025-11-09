#!/bin/zsh
# proxy.zsh - 代理管理

# 从配置文件读取代理设置
if [ -f "${0:A:h}/proxy.conf" ]; then
    source "${0:A:h}/proxy.conf"
else
    PROXY_HOST="${PROXY_HOST:-127.0.0.1}"
    PROXY_PORT="${PROXY_PORT:-7890}"
fi

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
    
    git config --global --unset http.proxy 2>/dev/null
    git config --global --unset https.proxy 2>/dev/null
    
    echo "❌ 代理已关闭"
}

proxy_status() {
    if [[ -n "$http_proxy" ]]; then
        echo "🟢 代理状态: 已开启"
        echo "   HTTP Proxy: $http_proxy"
        echo "   HTTPS Proxy: $https_proxy"
        local git_proxy=$(git config --global http.proxy 2>/dev/null)
        if [[ -n "$git_proxy" ]]; then
            echo "   Git Proxy: $git_proxy"
        fi
    else
        echo "🔴 代理状态: 已关闭"
    fi
}

proxy_test() {
    if [[ -n "$http_proxy" ]]; then
        echo "正在测试代理连接..."
        if curl -I -s --connect-timeout 5 https://www.google.com > /dev/null 2>&1; then
            echo "✅ 代理连接成功"
        else
            echo "❌ 代理连接失败"
        fi
    else
        echo "⚠️  代理未开启"
    fi
}

# 别名
alias pon='proxy_on'
alias poff='proxy_off'
alias pst='proxy_status'
alias ptest='proxy_test'
