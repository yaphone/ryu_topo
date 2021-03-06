#!/usr/bin/python

"""
Script created by VND - Visual Network Description (SDN version)
"""
from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSKernelSwitch, OVSLegacyKernelSwitch, UserSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.link import Link, TCLink

def topology():
    "Create a network."
    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch )

    c0 = net.addController('c0')

    print "*** Creating nodes"
    h1 = net.addHost( 'h1', mac='00:00:00:00:00:01', ip='10.0.0.1/24' )
    h2 = net.addHost( 'h2', mac='00:00:00:00:00:02', ip='10.0.0.2/24' )
    h3 = net.addHost( 'h3', mac='00:00:00:00:00:03', ip='10.0.0.3/24' )
    h4 = net.addHost( 'h4', mac='00:00:00:00:00:04', ip='10.0.0.4/24' )
    h5 = net.addHost( 'h5', mac='00:00:00:00:00:05', ip='10.0.0.5/24' )
    h6 = net.addHost( 'h6', mac='00:00:00:00:00:06', ip='10.0.0.6/24' )
    s1 = net.addSwitch( 's1', listenPort=6634, mac='00:00:00:00:00:07' )
    s2 = net.addSwitch( 's2', listenPort=6635, mac='00:00:00:00:00:08' )
    s3 = net.addSwitch( 's3', listenPort=6636, mac='00:00:00:00:00:09' )
    s4 = net.addSwitch( 's4', listenPort=6637, mac='00:00:00:00:00:10' )
    s5 = net.addSwitch( 's5', listenPort=6638, mac='00:00:00:00:00:11' )

    print "*** Creating links"
    net.addLink(s5, h5, 8, 0, bw=10 )
    net.addLink(s5, h4, 7, 0, bw=10 )
    net.addLink(s5, h3, 6, 0, bw=10 )
    net.addLink(s5, h2, 5, 0, bw=10 )
    net.addLink(h6, s1, 0, 5, bw=10 )
    net.addLink(s1, s2, 1, 1, bw=10 )
    net.addLink(s1, s3, 2, 1, bw=10 )
    net.addLink(s1, s4, 3, 1, bw=10 )
    net.addLink(h1, s1, 0, 4, bw=10 )
    net.addLink(s2, s5, 2, 1, bw=10 )
    net.addLink(s3, s5, 2, 2, bw=10 )
    net.addLink(s4, s5, 2, 3, bw=10 )

    print "*** Starting network"
    net.build()

    c0.start()
    s1.start([c0])
    s2.start([c0])
    s3.start([c0])
    s4.start([c0])
    s5.start([c0])
    

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

