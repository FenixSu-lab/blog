#!/bin/bash

# Hexo博客自动化部署脚本

echo "🚀 开始部署Hexo博客..."

# 1. 清理旧文件
echo "📁 清理旧文件..."
hexo clean

# 2. 生成静态文件
echo "🔨 生成静态文件..."
hexo generate

# 3. 检查生成是否成功
if [ ! -d "public" ]; then
    echo "❌ 生成失败，public目录不存在"
    exit 1
fi

# 4. 上传到服务器（需要配置SSH密钥）
echo "📤 上传文件到服务器..."
SERVER_USER="your-username"
SERVER_HOST="your-server-ip"
SERVER_PATH="/var/www/Fenix-blog"

# 使用rsync同步文件
rsync -avz --delete public/ $SERVER_USER@$SERVER_HOST:$SERVER_PATH/

# 5. 重启Nginx（可选）
echo "🔄 重启Nginx..."
ssh $SERVER_USER@$SERVER_HOST "sudo systemctl reload nginx"

echo "✅ 部署完成！"
echo "🌐 网站地址: http://your-domain.com" 