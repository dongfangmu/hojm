#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH


function v2ray(){
    echo "###   v2ray后端一键对接脚本v1.0   ###"
    echo "###     By Linux_Terminal       ###"
    echo "###     Update: 2020-03-16      ###"

    echo " "
    echo -e "\033[41;33m 本功能仅支持Debian 9，请勿在其他系统中运行 \033[0m"
    echo " "
    echo "---------------------------------------------------------------------------"
    echo " "

    echo " "
    echo -e "\033[42;37m 请输入节点ID \033[0m 参考格式 42"
    read nodeid
    echo " "

    echo " "
    echo "---------------------------------------------------------------------------"
    echo -e "\033[41;33m 请确认下列信息无误，任何失误需要重置操作系统！\033[0m"
    echo -e "\033[42;37m 节点ID \033[0m $nodeid"
    echo " "
    echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
    echo " "
    echo "---------------------------------------------------------------------------"

    read -n 1
    apt-get update -y
    apt-get install curl -y
    bash <(curl -L -s  https://raw.githubusercontent.com/dongfangmu/v2ray-sspanel-v3-mod_Uim-plugin/master/install-release.sh) \
    --panelurl https://shuigengliu.com --panelkey 111 --nodeid $nodeid \
    --downwithpanel 1 --speedtestrate 6 --paneltype 0 --usemysql 0
    systemctl start v2ray.service
    wget --no-check-certificate -O tcp.sh https://github.com/cx9208/Linux-NetSpeed/raw/master/tcp.sh && chmod +x tcp.sh && ./tcp.sh
    echo " "
    echo " "
    echo -e "\033[42;37m 安装完成 \033[0m"
}



function menu(){
    echo "###       node tool v1.3       ###"
    echo "###  By Twitter@Linux_Terminal ###"
    echo "###    Update: 2020-03-17      ###"
    echo ""

    echo "---------------------------------------------------------------------------"

    echo -e "\033[42;37m [1] \033[0m 安装v2ray后端"
    echo -e "\033[41;33m 请输入选项以继续，ctrl+C退出 \033[0m"

    opt=0
    read opt
    if [ "$opt"x = "1"x ]; then
        v2ray

    else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh
    fi
}

menu
