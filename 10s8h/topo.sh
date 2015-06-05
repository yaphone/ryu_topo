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
    s3 = net.addSwitch( 's3', listenPort=6673, mac='00:00:00:00:00:03' )
    s4 = net.addSwitch( 's4', listenPort=6674, mac='00:00:00:00:00:04' )
    s5 = net.addSwitch( 's5', listenPort=6675, mac='00:00:00:00:00:05' )
    s6 = net.addSwitch( 's6', listenPort=6676, mac='00:00:00:00:00:06' )
    s7 = net.addSwitch( 's7', listenPort=6677, mac='00:00:00:00:00:07' )
    s8 = net.addSwitch( 's8', listenPort=6678, mac='00:00:00:00:00:08' )
    s9 = net.addSwitch( 's9', listenPort=6679, mac='00:00:00:00:00:09' )
    s10 = net.addSwitch( 's10', listenPort=66710, mac='00:00:00:00:00:10' )
    s11 = net.addSwitch( 's11', listenPort=66711, mac='00:00:00:00:00:11' )
    s12 = net.addSwitch( 's12', listenPort=66712, mac='00:00:00:00:00:12' )
    h25 = net.addHost( 'h25', mac='00:00:00:00:00:25', ip='10.0.0.25/8' )
    h26 = net.addHost( 'h26', mac='00:00:00:00:00:26', ip='10.0.0.26/8' )
    h27 = net.addHost( 'h27', mac='00:00:00:00:00:27', ip='10.0.0.27/8' )
    h28 = net.addHost( 'h28', mac='00:00:00:00:00:28', ip='10.0.0.28/8' )
    h29 = net.addHost( 'h29', mac='00:00:00:00:00:29', ip='10.0.0.29/8' )
    h30 = net.addHost( 'h30', mac='00:00:00:00:00:30', ip='10.0.0.30/8' )
    h31 = net.addHost( 'h31', mac='00:00:00:00:00:31', ip='10.0.0.31/8' )
    h32 = net.addHost( 'h32', mac='00:00:00:00:00:32', ip='10.0.0.32/8' )

    print "*** Creating links"
    net.addLink(s4, s6, 3, 4)
    net.addLink(s3, s9, 3, 4)
    net.addLink(s12, h28, 4, 0)
    net.addLink(s12, h32, 3, 0)
    net.addLink(s11, h31, 4, 0)
    net.addLink(s11, h27, 3, 0)
    net.addLink(s8, h30, 4, 0)
    net.addLink(s8, h26, 3, 0)
    net.addLink(s7, h29, 4, 0)
    net.addLink(s7, h25, 3, 0)
    net.addLink(s10, s11, 3, 2)
    net.addLink(s9, s12, 3, 2)
    net.addLink(s5, s8, 3, 2)
    net.addLink(s6, s7, 3, 2)
    net.addLink(s10, s12, 2, 1)
    net.addLink(s9, s11, 2, 1)
    net.addLink(s4, s10, 2, 1)
    net.addLink(s6, s8, 2, 1)
    net.addLink(s5, s7, 2, 1)
    net.addLink(s3, s5, 1, 1)

    print "*** Starting network"
    net.build()
	
	c0.start()
    s3.start([c0])
    s4.start([c0])
    s5.start([c0])
    s6.start([c0])
    s7.start([c0])
    s8.start([c0])
    s9.start([c0])
    s10.start([c0])
    s11.start([c0])
    s12.start([c0])

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()
