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
    h23 = net.addHost( 'h23', mac='00:00:00:00:00:23', ip='10.0.0.23/8' )
    h24 = net.addHost( 'h24', mac='00:00:00:00:00:24', ip='10.0.0.24/8' )
    h25 = net.addHost( 'h25', mac='00:00:00:00:00:25', ip='10.0.0.25/8' )
    h26 = net.addHost( 'h26', mac='00:00:00:00:00:26', ip='10.0.0.26/8' )
    h27 = net.addHost( 'h27', mac='00:00:00:00:00:27', ip='10.0.0.27/8' )
    h28 = net.addHost( 'h28', mac='00:00:00:00:00:28', ip='10.0.0.28/8' )
    h29 = net.addHost( 'h29', mac='00:00:00:00:00:29', ip='10.0.0.29/8' )
    h30 = net.addHost( 'h30', mac='00:00:00:00:00:30', ip='10.0.0.30/8' )
    s39 = net.addSwitch( 's39', listenPort=66713, mac='00:00:00:00:00:39' )
    h42 = net.addHost( 'h42', mac='00:00:00:00:00:42', ip='10.0.0.42/8' )
    h43 = net.addHost( 'h43', mac='00:00:00:00:00:43', ip='10.0.0.43/8' )

    print "*** Creating links"
    net.addLink(h43, s39, 0, 4)
    net.addLink(h42, s39, 0, 3)
    net.addLink(s39, s2, 2, 3)
    net.addLink(s1, s39, 3, 1)
    net.addLink(s10, h30, 4, 0)
    net.addLink(s10, h29, 3, 0)
    net.addLink(s9, h28, 4, 0)
    net.addLink(s9, h27, 3, 0)
    net.addLink(s6, h26, 4, 0)
    net.addLink(s6, h25, 3, 0)
    net.addLink(s5, h24, 4, 0)
    net.addLink(s5, h23, 3, 0)
    net.addLink(s9, s8, 2, 3)
    net.addLink(s7, s10, 3, 2)
    net.addLink(s8, s10, 2, 1)
    net.addLink(s7, s9, 2, 1)
    net.addLink(s3, s6, 3, 2)
    net.addLink(s5, s4, 2, 3)
    net.addLink(s4, s6, 2, 1)
    net.addLink(s3, s5, 2, 1)
    net.addLink(s2, s8, 2, 1)
    net.addLink(s2, s4, 1, 1)
    net.addLink(s1, s7, 2, 1)
    net.addLink(s1, s3, 1, 1)

    print "*** Starting network"
    net.build()
	
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
<<<<<<< HEAD:11s10h/topo.sh
	s11.start([c0])
=======

>>>>>>> 1729f5c0dc70055870ad4f06fcf1f0979facf488:11s8h/topo.sh

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

