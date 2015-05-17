""" 
Programmer: Jason Thorpe (jthorpe@gmail.com)
Purpose:    includes the function `getAllConnectedSets()` which, given a graph 
            represented as a list of edges (defined by the nodes they connect),
            returns a list of all connected graphs.
"""

from __future__ import with_statement

def getAllConnectedSets(edges,size=None,verbose = False):
    """ Given a number of nodes and a list of the pairs of edges among those nodes, 
        return the next set of nodes and edges in the connected extension algorithm

        parameter: edges - a list with elements of the form (leftNode, rightNode)
                        
        return value:  a list of connected subsets of the graph

    """
    def extend(nodes,edges):
        """ This method is Where the actual work takes place.

            Rules: 

            1. Every edge in the edge in the current round becomes a node in 
                the next round.

            2. Every pair of edges that share an endpoint in the current round
                becomes an edge in the next round 

            3. The ends of edges are named.  In the first round, the names are the
                nodes that it joins.  In further rounds, the ends of a new edge that 
                is defined by two edges with a common node the previous round is 
                given the names of the non-joinng ends of the two edges from the previous 
                round.

            4. An edge whose left and right names are the same connects two identical
                nodes.

            parameters: 
            param: nodes - a list of nodes connected by the edges
            param: edges - a list with elements of the form (Nodes,Names) where
                            Nodes is a tuple of the form ( leftNode, rightNode,)
                            and Names is a tuple of the form (leftName, rightName,)

                            
            return values: newNodes,newEdges
            param: nodes - a list of nodes connected by the edges in the returned graph
            param: edges - a list with elements of the form (Nodes,Names) where
                            Nodes is a tuple of the form ( leftNode, rightNode,)
                            and Names is a tuple of the form (leftName, rightName,)

        """
        # takes a graph and computes the next connected-set graph
        if verbose: 
            import time
            print "started   with %s nodes and %s edges"%(len(nodes),len(edges))
            start = time.time()
        newEdges = []
        newNodes = set(edges) # rule 1
        for node in nodes:
            # EDGES THAT MEET AT THIS NODE
            nodeEdges = [edge for edge in edges if node in edge[:2]] # rule 2
            for i,j in ((i,j) for i in range(len(nodeEdges)) for j in range(i)):
                e0,e1 = nodeEdges[j],nodeEdges[i]
                name0 = e0[3-(e0[1] == node)]# rule 3
                name1 = e1[3-(e1[1] == node)]# rule 3
                if name0 < name1:
                    newEdge = [e0,e1, # rule 1
                              name0, name1,]# rule 3
                else:
                    newEdge = [e1,e0, # rule 1
                               name1, name0,]# rule 3
                newEdges.append(newEdge)
        if verbose: 
            print "starting with a forrest of %s nodes and %s edges"%(len(newNodes),len(newEdges))
        # COMBINE THE NODES THAT ARE IDENTICAL 
        for i,e in enumerate(newEdges):  
            if ((e[2] == e[3]) and # names indicate that the edge joins a mode to itself (rule 4)
                (e[0] != e[1])) :# But the objects it joins have different representations
                oldNode,newNode = e[:2]
                if oldNode in newNodes: 
                    newNodes.remove(oldNode)
                    #newNodes.pop(newNodes.index(oldNode))
                for i,E in enumerate(newEdges):
                    if E[0] == oldNode:
                        E[0] = newNode
                    if E[1] == oldNode:
                        E[1] = newNode
        # REMOVE THE COULDASAC EDGES 
        for i in range(len(newEdges)-1,-1,-1):  # rule 4
            if newEdges[i][0] == newEdges[i][1]:
                newEdges.pop(i)
        # MAKE THE EDGES HASHABLE in order to remove the duplicates
        newEdges = list(set( tuple(e) for e in newEdges ))
        if verbose: 
            print "  returning a forrest with %s nodes and %s edges in %s seconds"%(len(newNodes),len(newEdges),time.time() - start)
        return (newNodes,newEdges)
    #
    def intConverter(_n,_e,nRound):
        """ convert the nodes to integer representation for speed purposes.
        """
        _n2 = list(_n)
        _e2 = list(_e)
        for jn,n in enumerate(_n2):
            # nodes in this round represent edges in the last round
            _n2[jn]  = edgesByRound[nRound].index(n)
        for ie,e in enumerate(_e2):
            # edges in this round connected nodes in this round
            # which connect edges in the last round
            _e2[ie] = (
                       edgesByRound[nRound].index(e[0]),
                       edgesByRound[nRound].index(e[1]),
                      e[2],
                      e[3],
                      )
        return _n2,_e2
    #
    def nodeSet(i_node,nRound):
        """ param: i_node - an int representing the edge from the previous round
            param: nRound - the number of base nodes in this i_node
        """
        if nRound == 0:
            return nodes[i_node]
        out = []
        while nRound > 1:
            edge = edgesByRound[nRound-1][i_node] # the edge that this node represents
            i_node = edge[1] # right node
            out.append(edge[2]) # left name
            nRound -= 1
        edge = edgesByRound[nRound-1][i_node] # the edge that this node represents
        out.append(edge[2]) # left name
        out.append(edge[3]) # left name
        return out
    #
    # GET A LIST OF THE UNIQUE NODES
    nodes = list(set([e[0] for e in edges] + [e[1] for e in edges]))
    _n = nodes
    _e = [e+e for e in edges]
    # nodesByRound[i] contains nodes that represent subsets of size i+1 
    nodesByRound = [ _n ]
    # edgesByRound[i] contains edges that connectet nodes of the same index above
    edgesByRound = [ _e ]
    # FIGURE OUT WHEN TO STOP ITERATION
    maxNodes = len(nodes)
    if size:
        maxNodes = min(maxNodes,size)
    nRound = 0 # Keep tradk of the iterations
    # DO THE ACTUAL WORK
    if verbose: 
        print "%s connected subsets of size %s"%(len(_n),nRound+1)
    while nRound < maxNodes -1 and len(_e): # if there are no edges, then there is nothing to do.
        _n,_e = extend(_n,_e) # get the next connected-subset graph
        _n,_e = intConverter(_n,_e,nRound) # convert the nodes in the new graph to numeric representation
        edgesByRound.append( _e ) # keep track of the edges in this rounc
        nodesByRound.append( _n ) # keep track of the nodes in this rounc
        nRound += 1
        if verbose: 
            print "%s connected subsets of size %s"%(len(_n),nRound+1)
    if verbose: 
        print "process terminated after %s rounds, maxNodes: %s, n Edges: %s,n Nodes: %s"%(
                                    nRound,maxNodes,len(_e),len(_n))
    # process the return values
    if size:
        if nRound < size-1:
            return []
        else:
            return [nodeSet(n,nRound) for n in _n]
    else:
        out = [] + [[n] for n in nodesByRound[0]]
        for size in range(1,nRound+1):
            out.extend([nodeSet(ns,size) for ns in nodesByRound[size]])
        return out



if __name__ == "__main__":
    """ APPLY THE CONNECTED-SUBGRAPH ALGORITHM TO THE GRAPH IN THE FILE PROVIDED

        as an example, this script could be called from the terminal using 

            python connectedSubsets.py myFavoriteGraph.txt connectedSubsetsOfMyFavoriteGraph.txt 5

        which would result in (1) importing the graph defined in the file myFavoriteGraph.txt
        (2) identifying all connected sub-graphs of size 5, and (3) writing a list of these 
        connected subGraphs to the file connectedSubsetsOfMyFavoriteGraph.txt

        NOTE THAT sys.argv is assumed to have the elements:
        sys.argv[0]:  the name of this file (duh!)
        sys.argv[1]:  the file name of the full graph which containes 
                      the edges of a graph where each line in the file 
                      contains the name of two nodes that are connected by the
                      edge
        sys.argv[2]:  the file name into which connected subgraphs should be written
        sys.argv[3]:  (optional) the size of the connected sub-graphs desired
        

    """

    print "Note that this portion of the script is totally untested"

    import sys
    with open(sys.argv[1],'r') as fh:
        graph = [ll.split(',') for ll in fh.readlines()]

    if len(sys.argv) > 3:
        # a desired size for the connected sub-graphs is indicated
        out = getAllConnectedSets(graph,int(sys.argv[3]),verbose = True)
    else:
        out = getAllConnectedSets(graph,verbose = True)

    with open(sys.argv[2],'r') as fh:
        fh.writelines(out)

