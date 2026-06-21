#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 此脚本在 feeds 更新前执行（Update feeds 之前）
# 用于添加自定义软件源、下载额外源码等
#

# ========== 1. 修改默认 IP（可选，默认注释） ==========
# sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ========== 2. 添加 helloworld 源（先删除已有的再添加，避免重复） ==========
sed -i '/helloworld/d' feeds.conf.default
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> feeds.conf.default

# ========== 3. 添加 Argon 主题（如果 feeds 里没有） ==========
# 如果源码已经自带 argon，则此行可注释掉；若没有则克隆到 package 目录
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

# ========== 4. （可选）添加其他第三方源 ==========
# echo 'src-git other https://github.com/xxx/xxx.git' >> feeds.conf.default

exit 0
