#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#

# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了，其他的不要动
# sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate


#取消掉feeds.conf.default文件里面的helloworld的#注释
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default  #使用源码自带ShadowSocksR Plus+出国软件
#添加主题
echo 'src-git infinityfreedomng https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git' >>feeds.conf.default

