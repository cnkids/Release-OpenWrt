#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 此脚本在 feeds 更新和安装后执行（Load custom configuration 步骤）
# 用于修改源码、升级依赖、调整配置等
#

# ========== 1. 升级 Golang（确保 Xray-core 能编译） ==========
# 虽然你的 LEDE 版本 > 21.02，但强制升级到 1.23 确保万无一失
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# ========== 2. 修复 Samba36 配置（避免无效参数） ==========
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template

# ========== 3. 修改固件版本号显示（自定义） ==========
modelmark=R`TZ=UTC-8 date +%Y-%m-%d -d +"0"days`' by JIA'
sed -i "s/DISTRIB_REVISION='R[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/DISTRIB_REVISION='$modelmark/g" ./package/lean/default-settings/files/zzz-default-settings

# ========== 4. 更换默认主题为 Argon（覆盖多种 LuCI 变体） ==========
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-ssl-nginx/Makefile

# ========== 5. 移除不需要的默认应用（保留 helloworld） ==========
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

# ========== 6. （可选）修正 amdgpu 驱动换行（建议注释掉，避免潜在问题） ==========
# sed -i 's/kmod-drm-amdgpu \\/kmod-drm-amdgpu/g' target/linux/x86/Makefile

exit 0
