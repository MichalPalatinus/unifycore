#!/bin/sh

#XXX: toto uz je eth2
#ip link add bss0 type veth peer name corea1

ip link add vgsn0 type veth peer name corea2
ip link add internet0 type veth peer name corec3
ip link add corea3 type veth peer name coreb1
ip link add corea4 type veth peer name cored1
ip link add coreb2 type veth peer name cored2
ip link add corec1 type veth peer name coreb3
ip link add corec2 type veth peer name coree2
ip link add cored3 type veth peer name coree1
ip link add apn1 type veth peer name coree3
ip link add apn2 type veth peer name cored4

ifconfig vgsn0 192.168.27.2/24
ifconfig vgsn0 up

ifconfig internet0 172.20.255.254/16
ifconfig internet0 up
#ifconfig apn1 172.30.255.254/16
#ifconfig apn1 up
#ifconfig apn2 172.40.255.254/16
#ifconfig apn2 up


ethtool --offload vgsn0 rx off tx off

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
service dnsmasq restart

for INT in bss0 vgsn0 internet0 apn1 apn2 corea3 corea4 coreb2 corec1 corec2 cored3 corea1 corea2 corea3 coreb1 cored1 cored2 coreb3 coree2 coree1 eth2 coree3 cored4; do
	ip link set $INT mtu 1500
done
ip link set eth2 mtu 1600
#XXX: toto mozno nie je treba?
ip link set internet0 mtu 1200
ip link set apn1 mtu 1200
ip link set apn2 mtu 1200

