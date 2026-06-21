#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 此脚本在 feeds 更新和安装后执行（After Update feeds）
# 用于修改源码、升级依赖、调整配置等
#

# ========== 1. 升级 Golang（确保 Xray-core 能编译） ==========
# 适用于 LEDE 版本 <= 21.02，但即使版本 > 21.02 也强制升级到 1.23，确保万无一失
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# ========== 2. 修复 Samba36 配置（避免无效参数） ==========
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template

# ========== 3. 修改固件版本号显示（自定义） ==========
modelmark=R`TZ=UTC-8 date +%Y-%m-%d -d +"0"days`' by JIA'
sed -i "s/DISTRIB_REVISION='R[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/DISTRIB_REVISION='$modelmark/g" ./package/lean/default-settings/files/zzz-default-settings

# ========== 4. 更换默认主题为 Argon（覆盖多种 LuCI 变体） ==========
# 注意：如果 feeds 中找不到 luci-theme-argon，需要在 diy-part1.sh 中克隆到 package 目录
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-ssl-nginx/Makefile

# ========== 5. 移除不需要的默认应用（保留 helloworld） ==========
# 注意：这些 sed 命令会从 target/linux/x86/Makefile 中移除指定包名
# 请确保 helloworld 不在删除列表中（已确认不在）
sed -i 's/luci-app-zerotier //g' target/linux/x86/Makefile
sed -i 's/luci-app-unblockmusic //g' target/linux/x86/Makefile
sed -i 's/luci-app-xlnetacc //g' target/linux/x86/Makefile
sed -i 's/luci-app-jd-dailybonus //g' target/linux/x86/Makefile
sed -i 's/luci-app-ipsec-vpnd //g' target/linux/x86/Makefile
sed -i 's/luci-app-adbyby-plus //g' target/linux/x86/Makefile
sed -i 's/luci-app-sfe //g' target/linux/x86/Makefile
sed -i 's/luci-app-uugamebooster//g' target/linux/x86/Makefile
sed -i 's/-luci-app-flowoffload//g' target/linux/x86/Makefile
sed -i 's/luci-app-samba4//g' target/linux/x86/Makefile
sed -i 's/autosamba//g' target/linux/x86/Makefile
sed -i 's/luci-i18n-samba4-zh-cn//g' target/linux/x86/Makefile
sed -i 's/samba4-libs//g' target/linux/x86/Makefile
sed -i 's/samba4-server//g' target/linux/x86/Makefile

# ========== 6. （可选）修正 amdgpu 驱动换行（如果不需要可注释） ==========
# sed -i 's/kmod-drm-amdgpu \\/kmod-drm-amdgpu/g' target/linux/x86/Makefile

# ========== 7. （可选）其他自定义修改 ==========
# 例如：添加防火墙规则、修改默认时区等

exit 0
