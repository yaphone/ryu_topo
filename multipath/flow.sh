ovs-vsctl set bridge s1 protocols=OpenFlow13
ovs-vsctl set bridge s2 protocols=OpenFlow13
ovs-vsctl set bridge s3 protocols=OpenFlow13
ovs-vsctl set bridge s4 protocols=OpenFlow13
ovs-vsctl set bridge s5 protocols=OpenFlow13

ovs-ofctl -O OpenFlow13 add-group s1 group_id=5566,type=select,bucket=output:1,bucket=output:2,bucket=output:3
ovs-ofctl -O OpenFlow13 add-flow s1 in_port=4,actions=group:5566

ovs-ofctl -O OpenFlow13 add-flow s1 eth_type=0x0800,ip_dst=10.0.0.1,actions=output:4
ovs-ofctl -O OpenFlow13 add-flow s1 eth_type=0x0806,ip_dst=10.0.0.1,actions=output:4

ovs-ofctl -O OpenFlow13 add-flow s2 in_port=1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s2 in_port=2,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s3 in_port=1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s3 in_port=2,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s4 in_port=1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s4 in_port=2,actions=output:1

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.2,actions=output:4

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.3,actions=output:5
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.4,actions=output:6

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.5,actions=output:7
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.6,actions=output:8
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.7,actions=output:9

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.8,actions=output:10
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.9,actions=output:11
#ARP

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.2,actions=output:4

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.3,actions=output:5
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.4,actions=output:6
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.5,actions=output:7
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.6,actions=output:8
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.7,actions=output:9

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.8,actions=output:10
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.9,actions=output:11

ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0800,ip_dst=10.0.0.1,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s5 eth_type=0x0806,ip_dst=10.0.0.1,actions=output:1