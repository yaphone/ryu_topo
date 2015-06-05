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
        hub.spawn(self._monitor)
        hub.spawn(self._update_weight_edges)
        self.m = 0
        
        self.weight_switches_1 = {}
        self.weight_switches_2 = {}
        self.weight_edges = {}

    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        # install table-miss flow entry
        #
        # We specify NO BUFFER to max_len of the output action due to
        # OVS bug. At this moment, if we specify a lesser number, e.g.,
        # 128, OVS will send Packet-In with invalid buffer_id and
        # truncated packet data. In that case, we cannot output packets
        # correctly.
        match = parser.OFPMatch()
        actions = [parser.OFPActionOutput(ofproto.OFPP_CONTROLLER,
                                          ofproto.OFPCML_NO_BUFFER)]
        self.add_flow(datapath, 0, match, actions, hard_timeout=0)

    def add_flow(self, datapath, priority, match, actions, hard_timeout):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        inst = [parser.OFPInstructionActions(ofproto.OFPIT_APPLY_ACTIONS,
                                                     actions)]
        mod = parser.OFPFlowMod(datapath=datapath, priority=priority,
                                        match=match, instructions=inst, hard_timeout=hard_timeout)
        datapath.send_msg(mod)
#        print "*****************add_flow*****************"
        
    
    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
        msg = ev.msg
        datapath = msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        in_port = msg.match['in_port']

        pkt = packet.Packet(msg.data)
        eth = pkt.get_protocols(ethernet.ethernet)[0]
        
#        if (eth.ethertype==35020 or eth.ethertype==33011):
#            return        
            
                    
        
        dst = eth.dst
        src = eth.src
#        print src

        dpid = datapath.id
        self.mac_to_port.setdefault(dpid, {})   
        
        
        if src not in self.net.nodes():
            self.net.add_node(src)
            self.net.add_edge(dpid,src,{'port':in_port,'weight':1})
            self.net.add_edge(src,dpid,{'weight':1})
            
#            print "******add nodes*******"
#            print src
            
#            print "*****List of nodes*******"
#            print self.net.nodes()
#            
#            print "*****List of edges*******"
#            print self.net.edges()

        if dst in self.net.nodes():
            
#            try:
            path=nx.shortest_path(self.net, src, dst, weight='weight')
            
            print "*******Path**********"
            print path
            print dpid
            
            if dpid in path:
                next=path[path.index(dpid)+1]
                out_port=self.net[dpid][next]['port']
            else:
                return

#            except:
#                out_port = ofproto.OFPP_FLOOD
#                print 'No path'
        else:
            out_port = ofproto.OFPP_FLOOD
            
        actions = [parser.OFPActionOutput(out_port)]
        
        if out_port != ofproto.OFPP_FLOOD:
            match = parser.OFPMatch(in_port=in_port, eth_dst=dst)
            self.add_flow(datapath, 1, match, actions, hard_timeout=10)
            
        data = None
        if msg.buffer_id == ofproto.OFP_NO_BUFFER:
            date = msg.data
        
        out = parser.OFPPacketOut(
                    datapath=datapath, buffer_id=msg.buffer_id, in_port=in_port,
                    actions=actions, data=data)
        datapath.send_msg(out)            

    @set_ev_cls(event.EventSwitchEnter)
    def get_topology_data(self, ev):
         switch_list = get_switch(self.topology_api_app, None)
         self.switches=[switch.dp.id for switch in switch_list]
         print '************Switch List*********************'
#         print self.switches
         links_list = get_link(self.topology_api_app, None)
         self.links=[(link.src.dpid,link.dst.dpid,{'port':link.src.port_no}) for link in links_list]
         self.switches_nodes=[switch.dp for switch in switch_list]
         
         self.net.add_nodes_from(self.switches)
         self.net.add_edges_from(self.links)
         
         
#    def get_edges_weight():

    def _monitor(self):
        while True:
#            for dp in self.switches_nodes:
#                self._request_stats(dp)
            self._get_links_weight()            
                                
#            print self.links
#            print self.switches
            hub.sleep(10)
            
         
    def _request_stats(self,datapath,port_no=4294967295):
        self.logger.debug('send stats request: %016x', datapath.id)
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
               
        req = parser.OFPPortStatsRequest(datapath, 0, port_no)
        datapath.send_msg(req)
        
    @set_ev_cls(ofp_event.EventOFPPortStatsReply, MAIN_DISPATCHER)
    def _port_stats_reply_handler(self, ev):
        msg = ev.msg
        body = msg.body
        datapath = msg.datapath
        
        self.weight_switches_1.setdefault(datapath.id,{})
        self.weight_switches_2.setdefault(datapath.id,{})
        
#        self .logger.info('datapath              port '
#                          'rx-pkts  rx-bytes  rx-error '
#                          'tx-pkts  tx-bytes  tx-error')
#        self .logger.info('----------------  -------- '
#                          '-------- -------- -------- '
#                          '-------- -------- --------')
#        for stat in sorted(body, key=attrgetter('port_no')):
#            self.logger.info('%016x %8x %8d %8d %8d %8d %8d %8d',
#                              ev.msg.datapath.id, stat.port_no ,
#                              stat.rx_packets, stat.rx_bytes , stat.rx_errors ,
#                              stat.tx_packets, stat.tx_bytes , stat.tx_errors)
        for stat in sorted(body, key=attrgetter('port_no')):
#            print datapath.id
#            print stat.port_no
#            print stat.tx_packets
            if self.m%2 == 1:
                self.weight_switches_1[datapath.id][stat.port_no] = stat.tx_bytes
            if self.m%2 == 0:
                self.weight_switches_2[datapath.id][stat.port_no] = stat.tx_bytes
                
            
#        print '------------------------'
#        print self.m
#        print self.weight_switches_1
#        print self.weight_switches_2
            
            
    def _get_links_weight(self) :
#        print self.links
        self.m += 1
        for (u,v,d) in self.links:
            self._request_stats(self.switches_nodes[u-1], port_no=d['port'])
            
    def _update_weight_edges(self):
        while True:
#            print self.weight_switches_1
#            print self.weight_switches_2
            print '**************************'
            self.weight_edges = com_weight(self.weight_switches_1,self.weight_switches_2)
#            print self.weight_edges
#            print self.links
            add_edges_weight(self.weight_edges, self.links)
#            print '----------------------------'
            print self.net.edges(data=True)


            self.net.add_edges_from(self.links)
            hub.sleep(10)
            
            
            
            
    
        
