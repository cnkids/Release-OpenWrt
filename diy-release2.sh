#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

# 切换ramips内核为 5.10
sed -i 's/5.4/5.10/g' ./target/linux/ramips/Makefile

# 切换x86内核为 5.10
sed -i 's/5.4/5.10/g' ./target/linux/x86/Makefile

# 修复核心及添加温度显示
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template

# 修改版本号-webui
modelmark=R`TZ=UTC-8 date +%Y-%m-%d -d +"0"days`' by JIA'
sed -i "s/DISTRIB_REVISION='R[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/DISTRIB_REVISION='$modelmark/g" ./package/lean/default-settings/files/zzz-default-settings

#添加主题
echo 'src-git infinityfreedomng https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git' >>feeds.conf.default

#更换默认主题为opentopd，并删除bootstrap主题
sed -i 's#luci-theme-bootstrap#luci-theme-infinityfreedom-ng#g' feeds/luci/collections/luci/Makefile
sed -i 's/bootstrap/opentopd/g' feeds/luci/modules/luci-base/root/etc/config/luci

# Remove the default apps
sed -i 's/luci-app-zerotier //g' target/linux/x86/Makefile
sed -i 's/luci-app-unblockmusic //g' target/linux/x86/Makefile
sed -i 's/luci-app-xlnetacc //g' target/linux/x86/Makefile
sed -i 's/luci-app-jd-dailybonus //g' target/linux/x86/Makefile
sed -i 's/luci-app-ipsec-vpnd //g' target/linux/x86/Makefile
sed -i 's/luci-app-adbyby-plus //g' target/linux/x86/Makefile
sed -i 's/luci-app-sfe //g' target/linux/x86/Makefile
sed -i 's/luci-app-uugamebooster//g' target/linux/x86/Makefile
sed -i 's/-luci-app-flowoffload//g' target/linux/x86/Makefile
sed -i 's/kmod-drm-amdgpu \\/kmod-drm-amdgpu/g' target/linux/x86/Makefile


# Add ServerChan
# git clone https://github.com/tty228/luci-app-serverchan.git feeds/luci/applications/luci-app-serverchan
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan

# Add Onliner
# git clone https://github.com/rufengsuixing/luci-app-onliner.git feeds/luci/applications/luci-app-onliner
git clone https://github.com/rufengsuixing/luci-app-onliner.git package/luci-app-onliner

# Add OpenAppFilter app控制
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter


# Add PushBot全能推送 微信推送改版
#git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot

# Add Hello World
# svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr
# svn co https://github.com/siropboy/luci-app-vssr-plus/trunk/luci-app-vssr-plus package/new/luci-app-vssr-plus

git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb
#git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr

# Add Passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall
#rm -rf ./package/lean/dns2socks
#rm -rf ./package/lean/ipt2socks
#rm -rf ./package/lean/kcptun
#rm -rf ./package/lean/microsocks
#rm -rf ./package/lean/shadowsocksr-libev
#rm -rf ./package/lean/simple-obfs
#rm -rf ./package/lean/tcping
#rm -rf ./package/lean/trojan
# rm -rf ./package/lean/v2ray
#rm -rf ./package/lean/v2ray-plugin
#rm -rf ./package/openwrt-passwall/naiveproxy
#rm -rf ./package/openwrt-passwall/tcping
#rm -rf ./package/openwrt-passwall/xray-core
#rm -rf ./package/openwrt-passwall/v2ray
# rm -rf ./package/openwrt-passwall/v2ray-plugin
# rm -rf ./feeds/helloworld/naiveproxy
# rm -rf ./feeds/helloworld/tcping
# rm -rf ./feeds/helloworld/xray-core


# Add OpenClash
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash

# Add ADGuardHome
# git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-adguardhome ./package/luci-app-adguardhome
chmod -R 755 ./package/luci-app-adguardhome/*
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/adguardhome ./package/adguardhome
chmod -R 755 ./package/adguardhome/*

#替换为sirpdboy中文版netdata
rm -rf ./package/lean/luci-app-netdata 
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/luci-app-netdata
chmod -R 755 ./package/luci-app-netdata/*
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./package/netdata
chmod -R 755 ./package/netdata/*

# Add WOL Plus
svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus ./package/luci-app-wolplus
chmod -R 755 ./package/luci-app-wolplus/*


# Add GodProxy
git clone https://github.com/godros/luci-app-godproxy.git package/luci-app-godproxy

# Add luci-app-socat
# svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat ./package/luci-app-socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat ./package/luci-app-socat
chmod -R 755 ./package/luci-app-socat/*

# Add luci-app-advanced sirpdboy高级设置
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced ./package/luci-app-advanced
#chmod -R 755 ./package/luci-app-advanced/*


# Add SmartDNS
rm -rf ./feeds/packages/net/smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-smartdns ./package/luci-app-smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/smartdns
chmod -R 755 ./package/smartdns
chmod -R 755 ./package/luci-app-smartdns

# Add Poweroff
git clone https://github.com/jiawm/luci-app-poweroff.git package/poweroff
# git clone https://github.com/xylz0928/luci-app-shutdown package/luci-app-shutdown
#git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff #这个是默认
# curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
# curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
# chmod -R 755 ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
# chmod -R 755 ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm


# Add ddnsto and linkease
git clone https://github.com/linkease/nas-packages.git package/nas #添加ddnsto和linkease


