#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 此脚本在 feeds 更新前执行（Load custom feeds 步骤）
# 用于添加自定义软件源
#

# ========== 1. 修改默认 IP（可选，默认注释） ==========
# sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ========== 2. 添加 helloworld 源（先删除已有的再添加，避免重复） ==========
sed -i '/helloworld/d' feeds.conf.default
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> feeds.conf.default

# ========== 3. 添加 Argon 主题（可选，如果在 workflow 中已经 git clone 了则不需要） ==========
# 你的 workflow 中已经有 "install theme argon" 步骤克隆了 argon，所以这里不需要再重复

exit 0
