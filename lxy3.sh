#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH

function v2ray(){
    echo "###   v2ray后端   ###"
    echo "###     11      ###"
    echo "###     11      ###"

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
    echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf
    apt-get install sudo
    sudo apt-get update
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    systemctl start docker
    systemctl enable docker
    cd /etc
    wget https://github.com/dongfangmu/soga/releases/download/2.0.4/soga-linux64.tar.gz
    tar -xzf soga-linux64.tar.gz
    cd 
    docker run --restart=on-failure --name soga -d -v /etc/soga/:/etc/soga/ --network host dongfangmu/dongfangmu \
    --type=sspanel-uim \
    --server_type=v2ray \
    --api=webapi \
    --webapi_url=https://dlbtizi.net/ \
    --webapi_mukey=dong \
    --node_id=$nodeid \
    --proxy_protocol=true \
    --soga_key=uGzrFQjjdfTMmIsILudfeW1s5SDkGWw4
    echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
    sysctl -p
    echo " "
    echo " "
    echo -e "\033[42;37m 安装完成 \033[0m"
}

function menu(){
    echo "###         东方木自用          ###"
    echo "###            雪域宝贝         ###"
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
        v2ray
    fi
}

menu
