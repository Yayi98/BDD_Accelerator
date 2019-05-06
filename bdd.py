import numpy as np
import csv
import copy as cp

def load_data(filename): #To load csv files and create dictionaries of sku:sku_vol and loc:loc_vol
    with open(filename, mode='r') as infile:
        reader = csv.reader(infile)
        with open(filename[:len(filename)-4]+'_new.csv', mode='w') as outfile:
            writer = csv.writer(outfile)
            mydict = {rows[0]:float(rows[1]) for rows in reader}
    return mydict

sku_dict = load_data('sku_volume_test.csv')
loc_dict = load_data('location_capacity_test.csv')

class Node:
    node_count = 0
    node_dict = {}
    def __init__(self, sku, loc):
        self.skus = [sku]
        self.current_vol = loc_dict[loc] # Initialize assuming locations are empty inspite of skus being stored
        self.loc_id = loc
        self.node_id = Node.node_count
        self.neighbor = []
        Node.node_dict[self.node_id] = self
        Node.node_count += 1

# Capacity of locations and node_obj.skus can be updated as the skus are being placed only after bdd is generated. Not possible before.



class Edge:
    edge_count = 0
    edge_dict = {}
    def __init__(self,leftnode,rightnode):
        self.edge_id = Edge.edge_count
        self.leftnode = leftnode
        self.rightnode = rightnode
        leftnode.neighbor.append(rightnode)
        Edge.edge_dict[self.edge_id] = self
        Edge.edge_count += 1

class NodeBDD:
    nodeCount = 0
    nodeDict = {}
    def __init__(self, edgeId):
        self.edgeId = edgeId
        self.leftChild = None
        self.rightChild = None
        self.Id = NodeBDD.nodeCount
        NodeBDD.nodeCount += 1

    
def gen_edge_layer(leftlayer,rightlayer):
    for node in leftlayer:
        for _node in rightlayer:
            Edge(node,_node)

'''
L1 O  O  O  O  O
L2 O  O  O  O  O
L3 O  O  O  O  O
L4 O  O  O  O  O
   S1 S2 S3 S4 S5
'''



def gen_graph(sku_dict, loc_dict): # Should generate 140 edges but generating 144
    graph = [[Node(sku,loc) for loc in loc_dict.keys()] for sku in sku_dict.keys()] # Generating transpose of graph
    for i in range(len(sku_dict.keys()) - 1):
        gen_edge_layer(graph[i],graph[i+1])
    #return np.transpose(graph)

gen_graph(sku_dict, loc_dict)

# If edgeId in NodeBDD is negative, the edge between its parent and itself is dotted
# Hence, leftchild always has a negative edgeId

def gen_bdd(edgeDictKeys):
    for i in range(len(edgeDictKeys)):
        holder = [NodeBDD(i) for j in range(2**i)]
        for elem in holder:
            elem.leftChild = NodeBDD(-i-1)
            elem.rightChild = NodeBDD(i+1)

gen_bdd(range(10))
print('BDD node count', NodeBDD.nodeCount)

# 1st traversal of bdd (software traversal)
# Should update node.skus and capacities
# Prune '0' paths
# After a path is traversed node.skus and its capacity must be reset
# paths will be a list of all paths represented in binary. 0 go left, 1 go right

def gen_paths(nb_edges):
    paths = []
    string = '0' * (nb_edges - 1)
    for i in range(2**(nb_edges - 1)):
        paths.append(string[:len(string) - len(bin(i)[2:])] + bin(i)[2:])
    return paths

paths = gen_paths(5)
print('paths ', paths)

#def traverse_bdd(NodeBDD_dict, paths):






