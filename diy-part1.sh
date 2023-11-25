#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld;main' >>feeds.conf.default
# echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
# echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"
# echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >> "feeds.conf.default"
# echo "src-git pack https://github.com/sdhz153/packages.git;master" >> "feeds.conf.default"
# echo "src-git sbwml https://github.com/sbwml/luci-app-mosdns;v5" >> "feeds.conf.default"

# svn co https://github.com/kenzok8/small-package/trunk/redsocks2 package/diy/redsocks2
# svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/diy/luci-app-openclash
# svn co https://github.com/kenzok8/small-package/trunk/luci-app-smartdns package/diy/luci-app-smartdns
# svn co https://github.com/kenzok8/small-package/trunk/smartdns package/diy/smartdns
# svn co https://github.com/sbwml/luci-app-mosdns/trunk/luci-app-mosdns package/diy/luci-app-mosdns
# svn co https://github.com/sbwml/luci-app-mosdns/trunk/mosdns package/diy/mosdns
# svn co https://github.com/sbwml/luci-app-mosdns/trunk/v2dat package/diy/v2dat
# svn co https://github.com/kenzok8/small-package/trunk/ipt2socks package/diy/ipt2socks
# svn co https://github.com/kenzok8/small-package/trunk/microsocks package/diy/microsocks
# svn co https://github.com/kenzok8/small-package/trunk/dns2socks package/diy/dns2socks
# svn co https://github.com/kenzok8/small-package/trunk/pdnsd-alt package/diy/pdnsd-alt
# openclash
cd /workdir
#预置OpenClash内核和GEO数据
export CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version
export CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux
export CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux
export CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux

export CORE_TYPE=$(echo x86_64 | grep -Eiq "64|86" && echo "amd64" || echo "arm64")
export TUN_VER=$(curl -sfL $CORE_VER | sed -n "2{s/\r$//;p;q}")

export GEO_MMDB=https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
export GEO_SITE=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
export GEO_IP=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat

git clone --depth=1 --single-branch --branch "dev" https://github.com/vernesong/OpenClash.git

cd OpenClash/luci-app-openclash/root/etc/openclash
curl -sfL -o ./Country.mmdb $GEO_MMDB
curl -sfL -o ./GeoSite.dat $GEO_SITE
curl -sfL -o ./GeoIP.dat $GEO_IP

mkdir ./core && cd ./core

curl -sfL -o ./tun.gz "$CORE_TUN"-"$CORE_TYPE"-"$TUN_VER".gz
gzip -d ./tun.gz && mv ./tun ./clash_tun

curl -sfL -o ./meta.tar.gz "$CORE_MATE"-"$CORE_TYPE".tar.gz
tar -zxf ./meta.tar.gz && mv ./clash ./clash_meta

curl -sfL -o ./dev.tar.gz "$CORE_DEV"-"$CORE_TYPE".tar.gz
tar -zxf ./dev.tar.gz

chmod +x ./clash* ; rm -rf ./*.gz

cd /workdir/OpenClash
cp -r luci-app-openclash /workdir/openwrt/package/
