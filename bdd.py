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



print('SKU ',sku_dict['SKU1'])

class Node:
    node_count = 0
    node_dict = {}
    def __init__(self, sku, loc):
        self.sku_name = sku
        self.current_vol = loc_dict[loc] # Initialize assuming locations are empty inspite of skus being stored
        self.loc_id = loc
        self.node_id = Node.node_count
        #self.neighbor = []
        Node.node_dict[self.node_id] = self
        Node.node_count += 1

# Class for Edges in the graph. No class required for edges in the BDD
class Edge:
    edge_count = 0
    edge_dict = {}
    def __init__(self,leftnode,rightnode):
        self.edge_id = Edge.edge_count
        self.leftnode = leftnode
        self.rightnode = rightnode
        Edge.edge_dict[self.edge_id] = self
        Edge.edge_count += 1

# Class for nodes in the BDD. This is different from 'Node's in the graph
class NodeBDD:
    nodeCount = 0
    nodeDict = {}
    def __init__(self, edgeId, loc_dict):
        self.edgeId = edgeId
        self.leftChild = None
        self.rightChild = None
        self.Id = NodeBDD.nodeCount
        self.vol_dict = loc_dict
        self.ispathright = False
        NodeBDD.nodeDict[NodeBDD.nodeCount] = self
        NodeBDD.nodeCount += 1

# Terminal nodes in the BDD
class Leafnode:
    def __init__(self,path_validity):
        self.ispath = path_validity

# Generates edges for two columns in the graph
def gen_edge_layer(leftlayer,rightlayer):
    for node in leftlayer:
        for _node in rightlayer:
            Edge(node,_node)

# Structure of 'graph' is shown below

'''
L1 O  O  O  O  O
L2 O  O  O  O  O
L3 O  O  O  O  O
L4 O  O  O  O  O
   S1 S2 S3 S4 S5
'''

# Generating the graph
def gen_graph(sku_dict, loc_dict):
    # Generating nodes in the graph 
    graph = [[Node(sku,loc) for loc in loc_dict.keys()] for sku in sku_dict.keys()] # Generating transpose of graph
    # Generating edges in the graph
    for i in range(len(sku_dict.keys()) - 1):
        gen_edge_layer(graph[i],graph[i+1])
    # Orientation of the matrix is irrelevant as nodes in the graph have distinct identities


# In the BDD, node(edge_Id) -----> node(edge_Id + 1)
# This indicates that edge with edgeId = edge_Id in the graph is taken but not edge with edgeId = edge_Id + 1

######################
# This has bugs...
######################
def updateLocVol(sku_dict, loc_dict, edgeId):
    # print('LHS type = ',type(Edge.edge_dict[edgeId].rightnode.current_vol))
    # print('RHS nest type = ',type(Edge.edge_dict[edgeId].rightnode.sku_name)) 
    # print('RHS type = ',type(Node.node_dict[Edge.edge_dict[edgeId].rightnode.sku_name]))
    Edge.edge_dict[edgeId].rightnode.current_vol -= sku_dict[Edge.edge_dict[edgeId].rightnode.sku_name]
    if Edge.edge_dict[edgeId].rightnode.current_vol < 0:
        return None
    else:
        print('lhs nest type', Edge.edge_dict[edgeId].rightnode.loc_id)
        print('rhs nest type', Edge.edge_dict[edgeId].rightnode.sku_name)
        print('lhs type = ', type(loc_dict[Edge.edge_dict[edgeId].rightnode.loc_id]))
        print('rhs type = ', type(sku_dict[Edge.edge_dict[edgeId].rightnode.sku_name]))
        loc_dict[Edge.edge_dict[edgeId].rightnode.loc_id] -= sku_dict[Edge.edge_dict[edgeId].rightnode.sku_name]
        return loc_dict

# This function for generating the BDD and removing the infeasible / impossible paths simultaneously
def traverse_gen_bdd(nb_edges, sku_dict, loc_dict):
    nb_loc = len(loc_dict) # No. of locations
    check = False # This variable decides what value prevLayer has to take
    currLayer = None # This variable is for storing the previous layer in the BDD
    # Iteration on no. of edges
    # For the first loop prevLayer has to be just an edge (edge referring to edges in the graph) with an edgeId = 0
    for i in range(nb_edges): 
        if not check:
            prevLayer = [NodeBDD(i, loc_dict)]
        else:
            prevLayer = cp.deepcopy(currLayer)
        next_layer = []
        # Here node refers to nodes in the BDD
        for node in prevLayer:
            node.leftChild = NodeBDD(i+1, loc_dict)
            # Location capacity constraint = Locations running out of capacity is simulated here
            if updateLocVol(sku_dict, loc_dict, i) == None: # This is the exception raised in the function 'updateLocVol'
                node.rightChild = Leafnode(False)
                next_layer.append(node.leftChild)
            # Edge constraint between two columns of the graph

            '''
            Consider the first two columns in the graph
            There are nb_loc**2 no. of edges between them
            But you can only choose one of them
            So many paths in the BDD can be eliminated right away
            This is simulated here
            '''

            elif node.ispathright:
                node.rightChild = Leafnode(False)
                next_layer.append(node.leftChild)
            else:
                node.rightChild = NodeBDD(i+1, updateLocVol(sku_dict, loc_dict, i))
                node.rightChild.ispathright = True
                next_layer.extend([node.leftChild, node.rightChild])
        check = True
        currLayer = cp.deepcopy(next_layer)

        # Reset nodes at every nb_loc**2 layer in the bdd
        if i+1 % (nb_loc**2) == 0:
            for _node in currLayer:
                _node.ispathright = False
    
    return NodeBDD.nodeDict[0]

if __name__ == "__main__":
    sku_dict = load_data('sku_volume_test.csv')
    loc_dict = load_data('location_capacity_test.csv')
    gen_graph(sku_dict, loc_dict)
    testrun1 = traverse_gen_bdd(Edge.edge_count+1, sku_dict, loc_dict)
    print('testrun = ',testrun1)




# If edgeId in NodeBDD is negative, the edge between its parent and itself is dotted
# Hence, leftchild always has a negative edgeId

# def gen_bdd(nb_edges):
#     for i in range(nb_edges):
#         print('loop 1 i = ', i)
#         holder = [NodeBDD(i) for j in range(2**i)]
#         #print('holder = ', holder)
#         for elem in holder:
#             #print('elem.edgeId = ', elem.edgeId)
#             elem.leftChild = NodeBDD(i+1)
#             elem.rightChild = NodeBDD(i+1)

# gen_bdd(Edge.edge_count)

# def gen_paths(nb_edges):
#     paths = []
#     string = '0' * (nb_edges - 1)
#     for i in range(2**(nb_edges - 1)):
#         paths.append(string[:len(string) - len(bin(i)[2:])] + bin(i)[2:])
#     return paths

# # This dict will have paths as keys and path cost as value, initialized to None
# paths = gen_paths(Edge.edge_count)
# path_cost_dict = dict.fromkeys(paths, None)

# # 1st traversal of bdd (software traversal)
# # Should update node.sku and capacities
# # Prune '0' paths
# # After a path is traversed node.sku and its capacity must be reset
# # paths will be a list of all paths represented in binary. 0 go left, 1 go right

# def traverse_bdd(NodeBDD_dict, paths, loc_dict):
#     curr_node = NodeBDD.nodeDict[0]
#     invalid_paths = []
#     for path in paths:
#         path_validity = True
#         for direction in path:
#             if not int(direction):
#                 curr_node = curr_node.leftChild
#             else:
#                 # update capacity
#                 if 0 <= curr_node.edgeId < 2**len(loc_dict):
#                     # update capacity and node.sku of leftnode and rightnode attributes
#                     Edge.edge_dict[curr_node.edgeId].leftnode.current_vol -= sku_dict[Edge.edge_dict[curr_node.edgeId].leftnode.sku_name]
#                     Edge.edge_dict[curr_node.edgeId].rightnode.current_vol -= sku_dict[Edge.edge_dict[curr_node.edgeId].rightnode.sku_name]
#                 else:
#                     # update capacity and node.sku of rightnode attr only
#                     Edge.edge_dict[curr_node.edgeId].rightnode.current_vol -= sku_dict[Edge.edge_dict[curr_node.edgeId].rightnode.sku_name]
#                     if Edge.edge_dict[curr_node.edgeId].rightnode.current_vol < 0:
#                         path_validity = False
#                 curr_node = curr_node.rightChild
#         if not path_validity:
#             invalid_paths.append(path)
#     print('Zero paths ', invalid_paths)
#     return list(set(paths) ^ set(invalid_paths))

# #################### Begin Debugging ########################################

# print(traverse_bdd(NodeBDD.nodeDict, paths, loc_dict))