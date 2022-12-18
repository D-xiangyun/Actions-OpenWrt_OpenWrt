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
#

# Modify default IP
sed -i 's/192.168.15.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/timezone='UTC'/timezone='CST-8'/" package/base-files/files/bin/config_generate
sed -i "/timezone='CST-8'/a \ \ \ \ \ \ \ \ set system.@system[-1].zonename='Asia/Shanghai'" packag
/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='0.openwrt.pool.ntp.org'/add_list system.ntp.server='ntp.aliyu
.com'/" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='1.openwrt.pool.ntp.org'/add_list system.ntp.server='time1.clo
d.tencent.com'/" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='2.openwrt.pool.ntp.org'/add_list system.ntp.server='time.ustc
edu.cn'/" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='3.openwrt.pool.ntp.org'/add_list system.ntp.server='cn.pool.n
p.org'/" package/base-files/files/bin/config_generate