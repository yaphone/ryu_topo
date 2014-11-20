# 2 switches and 4 hosts
# very simple topo of mininet :)
#
#    host1 ----- |						|-------host3
#  				|						|
#			switch1 --------------- switch4 
#				|						|
#  host2 -------|		                |------host4
#                

from mininet.topo import Topo


class MyTopo(Topo):
    "Simple loop topology example."

    def __init__(self):
        "Create custom loop topo."

        # Initialize topology
        Topo.__init__(self)

        # Add hosts and switches
        host1 = self.addHost('h1')
        host2 = self.addHost('h2')
        host3 = self.addHost('h3')
        host4 = self.addHost('h4')
		
        switch1 = self.addSwitch("s1")
        switch2 = self.addSwitch("s2")

        # Add links
        self.addLink(switch1, host1, 1)
        self.addLink(switch1, host2, 2)
	self.addLink(switch2, host3, 2)
	self.addLink(switch2, host4, 3)


	self.addLink(switch1, switch2, 3, 1)


topos = {'mytopo': (lambda: MyTopo())}