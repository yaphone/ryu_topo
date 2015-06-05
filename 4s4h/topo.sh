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
    c0 = net.addController('c0')

    print "*** Creating nodes"
    s1 = net.addSwitch( 's1', listenPort=6673, mac='00:00:00:00:00:01' )
    s2 = net.addSwitch( 's2', listenPort=6674, mac='00:00:00:00:00:02' )
    s3 = net.addSwitch( 's3', listenPort=6675, mac='00:00:00:00:00:03' )
    s4 = net.addSwitch( 's4', listenPort=6676, mac='00:00:00:00:00:04' )
    h9 = net.addHost( 'h9', mac='00:00:00:00:00:09', ip='10.0.0.9/8' )
    h10 = net.addHost( 'h10', mac='00:00:00:00:00:10', ip='10.0.0.10/8' )
    h11 = net.addHost( 'h11', mac='00:00:00:00:00:11', ip='10.0.0.11/8' )
    h12 = net.addHost( 'h12', mac='00:00:00:00:00:12', ip='10.0.0.12/8' )

    print "*** Creating links"
    net.addLink(s4, h12, 4, 0)
    net.addLink(s4, h11, 3, 0)
    net.addLink(s3, h10, 4, 0)
    net.addLink(s3, h9, 3, 0)
    net.addLink(s2, s4, 2, 2)
    net.addLink(s1, s3, 2, 2)
    net.addLink(s2, s3, 1, 1)
    net.addLink(s1, s4, 1, 1)

    print "*** Starting network"
    net.build()
	
	c0.start()
	s1.start([c0])
	s2.start([c0])
	s3.start([c0])
	s4.start([c0])

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

