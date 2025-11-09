# My Dotfiles 🚀

个人开发环境配置文件，支持一键安装和卸载。

## ✨ 特性

- ✅ **模块化设计** - 配置文件独立管理，互不影响
- ✅ **一键安装/卸载** - 简单快速，自动备份
- ✅ **代理快速开关** - 支持终端和 Git 代理
- ✅ **丰富的命令别名** - 提高终端效率
- ✅ **Git 增强配置** - 美化日志，实用别名
- ✅ **安全备份** - 安装前自动备份原有配置

## 🚀 快速开始

### 方式一：远程安装（推荐）
```bash
git clone https://github.com/kimliss/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh uninstall.sh
./install.sh
source ~/.zshrc
```

### 方式二：一键脚本
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kimliss/dotfiles/main/install.sh)"
```

## 📖 使用说明

### 代理管理
```bash
pon            # 开启代理
poff           # 关闭代理
pst            # 查看代理状态
ptest          # 测试代理连接
```

### Git 别名
```bash
gs             # git status
ga             # git add
gc             # git commit
gp             # git push
gl             # git pull
glog           # 美化的 git log
```

### 其他别名
```bash
ll             # ls -lah
..             # cd ..
reload         # 重新加载 zsh 配置
zshconfig      # 编辑 .zshrc
```

## 🔧 自定义配置

### 修改代理地址

编辑 `config/zshrc.d/proxy.conf`:
```bash
PROXY_HOST="127.0.0.1"
PROXY_PORT="7890"
```

### 添加自己的别名

编辑 `config/zshrc.d/aliases.zsh`，添加你的别名。

### 添加环境变量

编辑 `config/zshrc.d/env.zsh`，添加你的环境变量。

## 🗑️ 卸载
```bash
cd ~/.dotfiles
./uninstall.sh
```

卸载脚本会：
1. 从 `.zshrc` 和 `.gitconfig` 移除配置引用
2. 提供恢复备份选项
3. 保留 dotfiles 目录和备份文件

## 📁 目录结构

```txt
dotfiles/
├── install.sh              # 安装脚本
├── uninstall.sh           # 卸载脚本
├── config/
│   ├── zshrc.d/           # zsh 配置模块
│   │   ├── loader.zsh     # 自动加载器
│   │   ├── proxy.zsh      # 代理管理
│   │   ├── aliases.zsh    # 命令别名
│   │   └── env.zsh        # 环境变量
│   └── git/
│       ├── gitconfig      # Git 配置
│       └── gitignore_global  # 全局忽略
└── backup/                # 备份目录
```

## 🔄 更新配置
```bash
cd ~/.dotfiles
git pull
source ~/.zshrc
```

## 💡 工作原理

本配置使用**引用机制**而非直接修改配置文件：

- `.zshrc` 中添加一行 `source` 语句引用 dotfiles
- `.gitconfig` 中添加 `[include]` 引用 dotfiles
- 卸载时只需删除引用行，不影响其他配置

## 📝 许可证

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！
