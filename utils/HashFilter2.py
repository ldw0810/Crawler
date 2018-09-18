#!/usr/bin/env python
# -*- coding: utf-8-*-

#hashlib 是一个专门提供hash算法的库，包括md5,sha1,sha224,sha256,sha384,sha512
import hashlib

class HashRing(object):
    def __init__(self, nodes=None, replicas=3):
        self.replicas = replicas
        self.ring = dict()
        self._sorted_keys = []
        if nodes:
            for node in nodes:
                self.add_node(node)

    def add_node(self, node):
        for i in range(0, self.replicas):
            key = self.gen_key('%s:%s' % (node, i))
            self.ring[key] = node
            self._sorted_keys.append(key)
        self._sorted_keys.sort()

    def remove_node(self, node):
        for i in range(0, self.replicas):
            key = self.gen_key('%s:%s' % (node, i))
            del self.ring[key]
            self._sorted_keys.remove(key)

    def get_node(self, string_key):
        return self.get_node_pos(string_key)[0]

    def get_node_pos(self, string_key):
        if not self.ring:
            return None, None
        key = self.gen_key(string_key)
        nodes = self._sorted_keys
        for i in range(0, len(nodes)):
            node = nodes[i]
            if key <= node:
                return self.ring[node], i
        return self.ring[nodes[0]], 0
    #hash key值
    def gen_key(self, key):
        m = hashlib.md5()
        m.update(key.encode())
        return int(m.hexdigest(), 16)

    def get_nodes(self, string_key):
        if not self.ring:
            yield None, None
        node, pos = self.get_node_pos(string_key)
        for key in self._sorted_keys[pos:]:
            yield self.ring[key]
        while True:
            for key in self._sorted_keys:
                yield self.ring[key]


if __name__ == '__main__':

    memcache_servers = ['192.168.0.246:11212',
                        '192.168.0.247:11212',
                        '192.168.0.249:11212']
    print memcache_servers

    ring = HashRing(memcache_servers)

    print ring
    server = ring.get_node('nodeurl')
    print(server)