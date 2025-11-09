# My Dotfiles

🚀 个人开发环境配置文件，支持一键安装。

## 特性

- ✅ zsh 代理快速开关
- ✅ Git 常用配置
- ✅ 常用命令别名
- ✅ 自动备份现有配置
- ✅ 交互式安装

## 快速安装

### 方式一：一键安装（推荐）
```bash
curl -fsSL https://raw.githubusercontent.com/kimliss/dotfiles/main/install.sh | bash
```

### 方式二：手动安装
```bash
# 克隆仓库
git clone https://github.com/kimliss/dotfiles.git ~/dotfiles

# 进入目录
cd ~/dotfiles

# 运行安装脚本
chmod +x install.sh
./install.sh

# 使配置生效
source ~/.zshrc
```

## 使用说明

### 代理管理
```bash
pon           # 开启代理
poff          # 关闭代理
pst           # 查看代理状态
ptest         # 测试代理连接
```

### 自定义配置

安装后可以修改代理配置：
```bash
vim ~/.zshrc  # 找到 PROXY_HOST 和 PROXY_PORT 修改
```

## 配置说明

### Zsh 配置
- 代理快速开关
- 常用命令别名
- Git 集成

### Git 配置
- 常用别名
- 默认编辑器
- 颜色配置

## 卸载
```bash
# 恢复备份的配置文件
mv ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
source ~/.zshrc
```

## 许可证

MIT License
