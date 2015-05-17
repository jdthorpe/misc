# An algorithm which identifies all connected subsets of graph supplied as a list of edges

This algorithm uses a dynamic programing approach which solves the 
problem of connected subsets in order of the size (number of nodes) 
of the connected subgraph.  This has several consequences including: 

1. the algorithm is faster when a maximum subset size is included and 

1. when a subset size is specified, all smaller connected graphs 
are identified in the process.

The algorithm runs in Order N^2 where N is the maximum number of connected 
subgraphs of a fixed size, but with proper indexing it could be reduced i
to order N*log(N).

Note that this this may be called within python via:

	import connectedSubsets
	subgraphs = getAllConnectedSets(edges)
	subgraphs = getAllConnectedSets(edges,size)

or from the command line via:

	python connectedSubsets.py in.txt out.txt 5

where, 

1. `in.txt` is the path to a text file containing the full graph 
where each line in the file contains the name of two nodes which are connected 
by a common edge in the graph

1. `out.txt` is the path of a file to be created and into which contains 
connected subgraphs should be written (one per line)

1.  Optionally, the size of the connected sub-graphs to be identified


## Simple examples

### examples 1: connected subsets of a small graph (a tree perhaps?)

    graph = (
            ('a','e'),
            ('a','f'),
            ('a','g'),
            ('b','a'),
            ('b','h'),
            ('b','i'),
            ('d','b'),
            ('d','j'),
            ('d','k'),
            ('l','b'),
            )

    # print all subgraphs
    for g in getAllConnectedSets(graph): 
        print g

    # print subgraphs of size 4, which is a bit faster because 
    # larger subgraphs are not generated.
    for g in getAllConnectedSets(graph,4): 
        print g

### examples 2: disconnected graphs are okay

    graph = [
            ('A','C',),
            ('B','C',),
            ('D','C',),
            ('D','E',),
            ('D','F',),
            # A REPEAT OF THE ABOVE, with in lower-case
            ('a','c',),
            ('b','c',),
            ('d','c',),
            ('d','e',),
            ('d','f',),
            ]

    # subgraphs of size 6 (i.e. None!)
    for s in getAllConnectedSets(graph,6): 
        print sorted(s)

    # print all subgraphs:
    for s in sorted([sorted(s) for s in getAllConnectedSets(graph)]): 
        print s

### Example 3: graphs with cycles are okay

    graph = [
            ('A','B',),
            ('B','C',),
            ('C','D',),
            ('D','E',),
            ('E','F',),
            ('E','A',),
            ('a','b',),
            ('b','c',),
            ('c','d',),
            ('d','e',),
            ('e','f',),
            ('e','a',),
            ]
    for s in sorted(getAllConnectedSets(graph)): 
        print s

### example 4: multiple cycles and complicated node names are okay

    graph = [
            ('Gene A','Gene B',),
            ('Gene B','Gene C',),
            ('Gene D','Gene E',),
            ('Gene E','Gene F',),
            ('Gene A','Gene D',),
            ('Gene E','Gene B',),
            ('Gene C','Gene F',),
            ('Gene D','Gene B',),
            ]
    x = getAllConnectedSets(graph)
    for s in x: print sorted(s)

