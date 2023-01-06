#!/bin/bash
#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---

## BOOK

export GRAPHS_HOME=/Users/tony/Projects/graphs

## BOOK - NEO4J

export NEO4J_VERSION=4.4.5
export NEO4J_HOME=${GRAPHS_HOME}/neo4j/neo4j-community-${NEO4J_VERSION}
export NEO4J_CONF=${NEO4J_HOME}/conf
export PATH=${PATH}:$NEO4J_HOME/bin

neo4j restart

## BOOK - GRAPHDB

export GRAPHDB_VERSION=10.0.0
export GRAPHDB_HOME=${GRAPHS_HOME}/graphdb/graphdb-${GRAPHDB_VERSION}
export PATH=${PATH}:$GRAPHDB_HOME/bin

kill -9 `cat ${GRAPHDB_HOME}/pid.txt`
graphdb -d -p ${GRAPHDB_HOME}/pid.txt

## BOOK - GREMLIN

export GREMLIN_VERSION=3.6.0
export GREMLIN_SERVER=apache-tinkerpop-gremlin-server-${GREMLIN_VERSION}
export GREMLIN_SERVER_HOME=${GRAPHS_HOME}/gremlin/${GREMLIN_SERVER}
export PATH=${PATH}:$GREMLIN_SERVER_HOME/bin
gremlin-server.sh restart

## BOOK - DGRAPH

export DGRAPH_HOME=${GRAPHS_HOME}/dgraph

cur_dir=`pwd`
cd $DGRAPH_HOME
dgraph alpha --lru_mb 1024 --graphql_extensions=false &
dgraph zero &
dgraph-ratel &
cd $cur_dir

###
