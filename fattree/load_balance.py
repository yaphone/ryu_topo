# Copyright (C) 2011 Nippon Telegraph and Telephone Corporation.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet
from ryu.lib.packet import ethernet
from ryu.lib import hub
from operator import attrgetter
from ryu.topology import event, switches
from ryu.topology.api import get_switch, get_link

from com_weight import com_weight, add_edges_weight

import eventlet
import time


import networkx as nx
import matplotlib.pyplot as plt


class SimpleSwitch13(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(SimpleSwitch13, self).__init__(*args, **kwargs)
        self.mac_to_port = {}
        self.topology_api_app=self
        self.net=nx.DiGraph()
        self.switches={}
        self.links={}
        self.switches_nodes={}
        self.DTRS={}
        
        self.weight_switches_1 = {}
        self.weight_switches_2 = {}
        self.weight_edges = {}
        
#        hub.spawn(self.show_avaliable_path)

        
    

    @set_ev_cls(event.EventSwitchEnter)
    def get_topology_data(self, ev):
         switch_list = get_switch(self.topology_api_app, None)
         self.switches=[switch.dp.id for switch in switch_list]
#         print '************Switch List*********************'
#         print self.switches
         links_list = get_link(self.topology_api_app, None)
         self.links=[(link.src.dpid,link.dst.dpid,{'port':link.src.port_no}) for link in links_list]
         self.switches_nodes=[switch.dp for switch in switch_list]
         
#         self.net.add_nodes_from(self.switches_nodes)
         self.net.add_edges_from(self.links)
         
         print "************self.nodes***********"
         print self.net.nodes()
         print "************self.edges***********"
         print self.net.edges()
         

         
    def show_avaliable_path(self):
        while True:
            for i in  self.net.nodes():
                for j in self.net.nodes(data=False):
                   self.DTRS[i][j] = nx.all_simple_paths(self.net, i, j)
                   
            print self.DTRS
            hub.sleep(3)
        

 