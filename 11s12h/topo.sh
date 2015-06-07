#!/usr/bin/python

"""
Script created by VND - Visual Network Description (SDN version)
"""
from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSKernelSwitch, UserSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.link import Link, TCLink

def topology():
    "Create a network."
    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch )
    c0 = net.addController('c0')

    print "*** Creating nodes"
    s1 = net.addSwitch( 's1', listenPort=6673, mac='00:00:00:00:00:01' )
    s2 = net.addSwitch( 's2', listenPort=6674, mac='00:00:00:00:00:02' )
    s3 = net.addSwitch( 's3', listenPort=6675, mac='00:00:00:00:00:03' )
    s4 = net.addSwitch( 's4', listenPort=6676, mac='00:00:00:00:00:04' )
    s5 = net.addSwitch( 's5', listenPort=6677, mac='00:00:00:00:00:05' )
    s6 = net.addSwitch( 's6', listenPort=6678, mac='00:00:00:00:00:06' )
    s7 = net.addSwitch( 's7', listenPort=6679, mac='00:00:00:00:00:07' )
    s8 = net.addSwitch( 's8', listenPort=66710, mac='00:00:00:00:00:08' )
    s9 = net.addSwitch( 's9', listenPort=66711, mac='00:00:00:00:00:09' )
    s10 = net.addSwitch( 's10', listenPort=66712, mac='00:00:00:00:00:10' )
    h11 = net.addHost( 'h11', mac='00:00:00:00:00:11', ip='10.0.0.11/8' )
    h12 = net.addHost( 'h12', mac='00:00:00:00:00:12', ip='10.0.0.12/8' )
    h13 = net.addHost( 'h13', mac='00:00:00:00:00:13', ip='10.0.0.13/8' )
    h14 = net.addHost( 'h14', mac='00:00:00:00:00:14', ip='10.0.0.14/8' )
    h15 = net.addHost( 'h15', mac='00:00:00:00:00:15', ip='10.0.0.15/8' )
    h16 = net.addHost( 'h16', mac='00:00:00:00:00:16', ip='10.0.0.16/8' )
    h17 = net.addHost( 'h17', mac='00:00:00:00:00:17', ip='10.0.0.17/8' )
    h18 = net.addHost( 'h18', mac='00:00:00:00:00:18', ip='10.0.0.18/8' )
    s44 = net.addSwitch( 's44', listenPort=66713, mac='00:00:00:00:00:44' )
    h47 = net.addHost( 'h47', mac='00:00:00:00:00:47', ip='10.0.0.47/8' )
    h48 = net.addHost( 'h48', mac='00:00:00:00:00:48', ip='10.0.0.48/8' )
    h49 = net.addHost( 'h49', mac='00:00:00:00:00:49', ip='10.0.0.49/8' )
    h50 = net.addHost( 'h50', mac='00:00:00:00:00:50', ip='10.0.0.50/8' )

    print "*** Creating links"
    net.addLink(s44, h50, 6, 0)
    net.addLink(h49, s44, 0, 5)
    net.addLink(h48, s44, 0, 4)
    net.addLink(h47, s44, 0, 3)
    net.addLink(s44, s2, 2, 4)
    net.addLink(s44, s1, 1, 6)
    net.addLink(s2, s8, 3, 5)
    net.addLink(s1, s7, 5, 4)
    net.addLink(s2, s4, 2, 4)
    net.addLink(s1, s3, 1, 3)
    net.addLink(s9, s8, 4, 2)
    net.addLink(s7, s10, 2, 4)
    net.addLink(s8, s10, 1, 3)
    net.addLink(s7, s9, 1, 3)
    net.addLink(s10, h18, 2, 0)
    net.addLink(s10, h17, 1, 0)
    net.addLink(s9, h16, 2, 0)
    net.addLink(s9, h15, 1, 0)
    net.addLink(s6, h14, 4, 0)
    net.addLink(s6, h13, 3, 0)
    net.addLink(s5, h12, 4, 0)
    net.addLink(s5, h11, 3, 0)
    net.addLink(s5, s4, 2, 2)
    net.addLink(s3, s6, 2, 2)
    net.addLink(s4, s6, 1, 1)
    net.addLink(s3, s5, 1, 1)

    print "*** Starting network"
    net.build()

    print "*** Running CLI"
    CLI( net )
	
    c0.start()
    s1.start([c0])
    s2.start([c0])
    s3.start([c0])
    s4.start([c0])
    s5.start([c0])
    s6.start([c0])
    s7.start([c0])
    s8.start([c0])
    s9.start([c0])
    s10.start([c0])
    s11.start([c0])

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

