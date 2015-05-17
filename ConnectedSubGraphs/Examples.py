""" 
Programmer: Jason Thorpe (jthorpe@gmail.com)
Purpose:    an example of `getAllConnectedSets(), which illustrates that ` 
            graphs with nodes with low degree have relatively few connected subsets 

"""

import random
import time
import csv

# --------------------------------------------------------------------------------
#  Define some convenience functions for the example
# --------------------------------------------------------------------------------

def Summary(x,fun = lambda x:x):
    """ A convience function for summarizing the contents of a list or dict  
        inspired by the `lapply()` function in R
    """
    counts = {}
    if isinstance(x,dict):
        for v in x.itervalues():
            V = fun(v)
            if V in counts:
                 counts[V] += 1
            else:
                 counts[V] = 1
    elif isinstance(x,(tuple,list)):
        for v in x:
            V = fun(v)
            if V in counts:
                 counts[V] += 1
            else:
                 counts[V] = 1
    else: 
        assert False, 'bad x value'
    return counts


def graphSummary(pairs):
    """ summary statistics for a graph 
    """
    return Summary(Summary([e[0] for e in pairs] + [e[1] for e in pairs]))

# 
def product(*args, **kwds):
    """ a convenience function for iterating over the 
        outer product of two or more objects ( equivelent to  
        itertools.product, e.g.: 

            product('ABCD', 'xy') --> Ax Ay Bx By Cx Cy Dx Dy
            product(range(2), repeat=3) --> 000 001 010 011 100 101 110 111

        )
    """
    pools = map(tuple, args) * kwds.get('repeat', 1)
    result = [[]]
    for pool in pools:
        result = [x+[y] for x in result for y in pool]
    for prod in result:
        yield tuple(prod)



# --------------------------------------------------------------------------------
# Define a function that generates a random graphs
# --------------------------------------------------------------------------------

# LETTERS = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',)
LETTERS = range(26) # more efficient...

def buildRandNetwork(nNodes,maxDegree=2,nLoops=0):
    """ Builds list of node pairs that represent a graph by growing a tree 
    and then optionally adding up to nLoops cycles within the tree.  

    The degree of each node is limited to be at most maxDegree, and 
    the the algorithm may attempt to put up to nLoops into the graph,
    though it may not always be sucessful at it depending on the maximum
    degree allowed in the graph.
    """
    assert maxDegree > 1, "maxDegree must be greater than 1"
    availableNodes = {LETTERS[nNodes-1]:0}
    pairs = set()
    # EXTEND THE TREE WITHOUT CYCLES
    for i in range(nNodes-1):
        this = LETTERS[i]
        # select an available node
        other = availableNodes.keys()[random.randint(0,len(availableNodes)-1)]
        otherConn = availableNodes.pop(other)
        otherConn +=1
        pairs.add((this,other))
        #select a 
        availableNodes[this] = 1
        if otherConn < maxDegree:
            availableNodes[other] = otherConn
    print "edges without cycles: %s"%(len(pairs))
    # NOW ADD IN THE CYCLES
    attempts = 0
    maxAttempts =  nLoops*3
    while (len(pairs) < nNodes + nLoops - 1) and attempts < maxAttempts:
        attempts += 1
        for i in range(nLoops):
            this = availableNodes.keys()[random.randint(0,len(availableNodes)-1)]
            thisConn = availableNodes.pop(this)
            other = availableNodes.keys()[random.randint(0,len(availableNodes)-1)]
            otherConn = availableNodes.pop(other)
            pairs.add((this,other))
            # incriment the number of edges per node
            thisConn +=1
            otherConn +=1
            if thisConn < maxDegree:
                availableNodes[this] = thisConn
            if otherConn < maxDegree:
                availableNodes[other] = otherConn
    return list(pairs)



# --------------------------------------------------------------------------------
# and now (finally) the example:
#
#     GENERATE RANDOM GRAPHS AND COUNT THE CONNECTED SUBSETS BY SIZE
#
# --------------------------------------------------------------------------------
# Note that the summary statistics are written to the file ~/Desktop/summary


with open('~/Desktop/summary.csv','w') as fh:
    writer = csv.writer(fh)
    for maxSize,edgesPerNode in product( (12,15,18), (3,4,5),):
        _edges = ['edges_'+str(i+1) for i in range(edgesPerNode)]
        _sets = ['subsets_'+str(i+1) for i in range(maxSize)]
        writer.writerow(['time']+_edges+_sets)
        for rep in range(15):
            # GENERATE A GRAPH
            print '----------------------------------------'
            print "size %s, edges %s, rep %s"%(maxSize,edgesPerNode,rep)
            pairs = buildRandNetwork(nNodes = maxSize,maxDegree = edgesPerNode,nLoops = 0)
            gs = graphSummary(pairs) 
            _edges = [ gs.get(i + 1,0) for i in range(edgesPerNode)]
            print '----------------------------------------'
            # GET THE SUBSETS
            start = time.time()
            tmp3 = getAllConnectedSets3(pairs)
            duration = time.time() - start
            # DO THE REPORTING
            print 'finished in %s seconds'%(duration)
            ss = Summary(tmp3,len)
            _sets = [ss.get(i+1,0) for i in range(maxSize)]
            writer.writerow([duration]+_edges+_sets)


# GENERATE RANDOM GRAPHS AND COUNT THE CONNECTED SUBSETS OF SIZE 5
reps = 5
maxSize = 22
durations5 = []
durations5_2 = []
for i in range(reps):
    print '----------------------------------------'
    pairs = buildRandNetwork(nNodes = 15,maxDegree = 3,nLoops = 0)
    print '----------------------------------------'
    # JUST THE SUBSETS OF SIZE 5
    print 'getAllConnectedSets EXTRA MODIFIED'
    start = time.time()
    tmp1 = getAllConnectedSets3(pairs,maxSize)
    durations5.append( time.time() - start)
    tmp1 = 
    del tmp1

