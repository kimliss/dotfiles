#!/bin/bash
# uninstall.sh - 卸载脚本

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}➜${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARKER="# === Dotfiles Configuration ==="

echo "================================================"
echo "       Dotfiles 卸载脚本"
echo "================================================"
echo ""

# 读取安装信息
if [ -f "$DOTFILES_DIR/.install_info" ]; then
    source "$DOTFILES_DIR/.install_info"
    print_info "检测到安装信息"
    print_info "安装日期: $INSTALL_DATE"
    print_info "备份目录: $BACKUP_DIR"
    echo ""
fi

# 从配置文件中移除引用
remove_source_lines() {
    local config_file=$1
    
    if [ ! -f "$config_file" ]; then
        print_warning "$config_file 不存在，跳过"
        return 0
    fi
    
    if ! grep -q "$MARKER" "$config_file"; then
        print_info "$config_file 中没有 dotfiles 配置"
        return 0
    fi
    
    # 创建临时文件，删除 marker 之后的所有内容直到文件末尾
    local temp_file="${config_file}.tmp"
    sed "/$MARKER/,\$d" "$config_file" > "$temp_file"
    
    # 替换原文件
    mv "$temp_file" "$config_file"
    
    print_success "已从 $config_file 移除 dotfiles 配置"
}

# 卸载 zsh 配置
uninstall_zsh() {
    print_info "卸载 zsh 配置..."
    remove_source_lines "$HOME/.zshrc"
}

# 卸载 git 配置
uninstall_git() {
    print_info "卸载 git 配置..."
    
    local gitconfig="$HOME/.gitconfig"
    local dotfiles_gitconfig="$DOTFILES_DIR/config/git/gitconfig"
    
    if [ -f "$gitconfig" ]; then
        # 移除 include 配置
        local temp_file="${gitconfig}.tmp"
        grep -v "path = $dotfiles_gitconfig" "$gitconfig" > "$temp_file" || true
        
        # 如果移除后 [include] 部分为空，也删除 [include]
        sed -i.bak '/^\[include\]$/,/^$/ { /^\[include\]$/d; /^$/d; }' "$temp_file"
        rm -f "${temp_file}.bak"
        
        mv "$temp_file" "$gitconfig"
        print_success "已从 .gitconfig 移除 dotfiles 配置"
    fi
    
    # 取消全局 gitignore 设置
    git config --global --unset core.excludesfile 2>/dev/null || true
}

# 恢复备份
restore_backup() {
    if [ -z "$BACKUP_DIR" ] || [ ! -d "$BACKUP_DIR" ]; then
        print_warning "未找到备份目录"
        return 0
    fi
    
    echo ""
    read -p "是否要恢复备份的配置文件? (y/n): " restore_choice
    
    if [[ ! $restore_choice =~ ^[Yy]$ ]]; then
        print_info "跳过恢复备份"
        return 0
    fi
    
    print_info "恢复备份文件..."
    
    # 恢复 .zshrc
    if [ -f "$BACKUP_DIR/.zshrc" ]; then
        cp "$BACKUP_DIR/.zshrc" "$HOME/.zshrc"
        print_success "已恢复 .zshrc"
    fi
    
    # 恢复 .gitconfig
    if [ -f "$BACKUP_DIR/.gitconfig" ]; then
        cp "$BACKUP_DIR/.gitconfig" "$HOME/.gitconfig"
        print_success "已恢复 .gitconfig"
    fi
}

# 主卸载流程
main() {
    echo "将要执行以下操作："
    echo "  1. 从 .zshrc 移除配置引用"
    echo "  2. 从 .gitconfig 移除配置引用"
    echo "  3. (可选) 恢复备份的原始配置"
    echo ""
    read -p "确认继续? (y/n): " confirm
    echo ""
    
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        print_info "已取消卸载"
        exit 0
    fi
    
    uninstall_zsh
    uninstall_git
    restore_backup
    
    # 删除安装信息
    rm -f "$DOTFILES_DIR/.install_info"
    
    echo ""
    echo "================================================"
    print_success "卸载完成！"
    echo "================================================"
    echo ""
    print_info "dotfiles 目录仍然保留在: $DOTFILES_DIR"
    print_info "备份文件保留在: $BACKUP_DIR"
    echo ""
    echo "如需完全删除，请手动执行："
    echo "  ${YELLOW}rm -rf $DOTFILES_DIR${NC}"
    echo ""
    echo "使配置生效："
    echo "  ${GREEN}source ~/.zshrc${NC}"
    echo ""
}

main
