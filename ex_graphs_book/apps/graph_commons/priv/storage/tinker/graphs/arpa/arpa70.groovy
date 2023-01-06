/***
 * Excerpted from "Exploring Graphs with Elixir",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit https://pragprog.com/titles/thgraphs for more book information.
***/
// ####
// # ARPANET - Dec 1970 [1]
// #
// # [1] http://mercury.lcs.mit.edu/~jnc/tech/arpalog.html
// ####


//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)


// Site: UCLA

ucla = graph.addVertex(label, "Node",
  "id", "ucla", "type", "IMP", "name", "UCLA"
)

ucla_h1 = graph.addVertex(label, "Host",
  "id", "ucla_h1", "name", "360/91"
)

ucla_h2 = graph.addVertex(label, "Host",
  "id", "ucla_h2", "name", "360/91"
)

ucla_h1.addEdge('H_LINK', ucla,
  'labelE', 'H_LINK',
)

ucla_h2.addEdge('H_LINK', ucla,
  'labelE', 'H_LINK',
)


// Site: SRI

sri = graph.addVertex(label, "Node",
  "id", "ucla", "type", "IMP", "name", "SRI"
)

sri_h1 = graph.addVertex(label, "Host",
  "id", "sri_h1", "name", "PDP-10"
)

sri_h2 = graph.addVertex(label, "Host",
  "id", "sri_h2", "name", "XDS-940"
)

sri_h1.addEdge('H_LINK', sri,
  'labelE', 'H_LINK',
)

sri_h2.addEdge('H_LINK', sri,
  'labelE', 'H_LINK',
)


// Site: UTAH

utah = graph.addVertex(label, "Node",
  "id", "utah", "type", "IMP", "name", "UTAH"
)

utah_h1 = graph.addVertex(label, "Host",
  "id", "utah_h1", "name", "PDP-10"
)

utah_h1.addEdge('H_LINK', utah,
  'labelE', 'H_LINK',
)


// Site: MIT

mit = graph.addVertex(label, "Node",
  "id", "mit", "type", "IMP", "name", "MIT"
)

mit_h1 = graph.addVertex(label, "Host",
  "id", "mit_h1", "name", "PDP-10"
)

mit_h2 = graph.addVertex(label, "Host",
  "id", "mit_h2", "name", "PDP-10"
)

mit_h3 = graph.addVertex(label, "Host",
  "id", "mit_h3", "name", "GE-645"
)

mit_h1.addEdge('H_LINK', utah,
  'labelE', 'H_LINK',
)

mit_h2.addEdge('H_LINK', utah,
  'labelE', 'H_LINK',
)

mit_h3.addEdge('H_LINK', utah,
  'labelE', 'H_LINK',
)


// Site: LINCOLN

lincoln = graph.addVertex(label, "Node",
  "id", "lincoln", "type", "IMP", "name", "LINCOLN"
)

lincoln_h1 = graph.addVertex(label, "Host",
  "id", "lincoln_h1", "name", "360/67"
)

lincoln_h2 = graph.addVertex(label, "Host",
  "id", "lincoln_h2", "name", "TX2"
)

lincoln_h3 = graph.addVertex(label, "Host",
  "id", "lincoln_h3", "name", "TSP"
)

lincoln_h1.addEdge('H_LINK', lincoln,
  'labelE', 'H_LINK',
)

lincoln_h2.addEdge('H_LINK', lincoln,
  'labelE', 'H_LINK',
)

lincoln_h3.addEdge('H_LINK', lincoln,
  'labelE', 'H_LINK',
)


// Site: CASE

case_ = graph.addVertex(label, "Node",
  "id", "case", "type", "IMP", "name", "CASE"
)

case_h1 = graph.addVertex(label, "Host",
  "id", "case_h1", "name", "PDP-10"
)

case_h1.addEdge('H_LINK', case_,
  'labelE', 'H_LINK',
)


// Site: CARNEGIE

carnegie = graph.addVertex(label, "Node",
  "id", "carnegie", "type", "IMP", "name", "CARNEGIE"
)

carnegie_h1 = graph.addVertex(label, "Host",
  "id", "carnegie_h1", "name", "PDP-10"
)

carnegie_h1.addEdge('H_LINK', carnegie,
  'labelE', 'H_LINK',
)


// Site: HARVARD

harvard = graph.addVertex(label, "Node",
  "id", "harvard", "type", "IMP", "name", "HARVARD"
)

harvard_h1 = graph.addVertex(label, "Host",
  "id", "harvard_h1", "name", "PDP-1"
)

harvard_h2 = graph.addVertex(label, "Host",
  "id", "harvard_h2", "name", "PDP-10"
)

harvard_h1.addEdge('H_LINK', harvard,
  'labelE', 'H_LINK',
)

harvard_h2.addEdge('H_LINK', harvard,
  'labelE', 'H_LINK',
)


// Site: BBN

bbn = graph.addVertex(label, "Node",
  "id", "bbn", "type", "IMP", "name", "BBN"
)

bbn_h1 = graph.addVertex(label, "Host",
  "id", "bbn_h1", "name", "DDP-516"
)

bbn_h2 = graph.addVertex(label, "Host",
  "id", "bbn_h2", "name", "PDP-10"
)

bbn_h1.addEdge('H_LINK', bbn,
  'labelE', 'H_LINK',
)

bbn_h2.addEdge('H_LINK', bbn,
  'labelE', 'H_LINK',
)


// Site: RAND

rand = graph.addVertex(label, "Node",
  "id", "rand", "type", "IMP", "name", "RAND"
)

rand_h1 = graph.addVertex(label, "Host",
  "id", "rand_h1", "name", "IBM 1800"
)

rand_h2 = graph.addVertex(label, "Host",
  "id", "rand_h2", "name", "360/65"
)

rand_h1.addEdge('H_LINK', rand,
  'labelE', 'H_LINK',
)

rand_h2.addEdge('H_LINK', rand,
  'labelE', 'H_LINK',
)


//
// SEGMENT 2 - Inner Path (Up from UCLA to SRI)


// Site: UCSB

ucsb = graph.addVertex(label, "Node",
  "id", "ucsb", "type", "IMP", "name", "UCSB"
)

ucsb_h1 = graph.addVertex(label, "Host",
  "id", "ucsb_h1", "name", "360/75"
)

ucsb_h1.addEdge('H_LINK', ucsb,
  'labelE', 'H_LINK',
)


//
// SEGMENT 3 - Inner Path (Up from RAND to SRI)


// Site: STANFORD

stanford = graph.addVertex(label, "Node",
  "id", "stanford", "type", "IMP", "name", "STANFORD"
)

stanford_h1 = graph.addVertex(label, "Host",
  "id", "stanford_h1", "name", "PDP-10"
)

stanford_h1.addEdge('H_LINK', stanford,
  'labelE', 'H_LINK',
)


//
// SEGMENT 4 - Inner Path (Up from RAND to UTAH)


// Site: SDC

sdc = graph.addVertex(label, "Node",
  "id", "sdc", "type", "IMP", "name", "SDC"
)

sdc_h1 = graph.addVertex(label, "Host",
  "id", "sdc_h1", "name", "DDP-516"
)

sdc_h2 = graph.addVertex(label, "Host",
  "id", "sdc_h2", "name", "360/67"
)

sdc_h1.addEdge('H_LINK', sdc,
  'labelE', 'H_LINK',
)

sdc_h2.addEdge('H_LINK', sdc,
  'labelE', 'H_LINK',
)


//
// SEGMENT 5 - Inner Path (Up from BBN to MIT)


// NETWORK (10+2+2+2+1=17)

//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)

ucla.addEdge('N_LINK', sri, 'labelE', 'N_LINK')
sri.addEdge('N_LINK', utah, 'labelE', 'N_LINK')
ucla.addEdge('N_LINK', mit, 'labelE', 'N_LINK')
mit.addEdge('N_LINK', lincoln, 'labelE', 'N_LINK')
lincoln.addEdge('N_LINK', case_, 'labelE', 'N_LINK')
case_.addEdge('N_LINK', carnegie, 'labelE', 'N_LINK')
carnegie.addEdge('N_LINK', harvard, 'labelE', 'N_LINK')
harvard.addEdge('N_LINK', bbn, 'labelE', 'N_LINK')
bbn.addEdge('N_LINK', rand, 'labelE', 'N_LINK')
rand.addEdge('N_LINK', ucla, 'labelE', 'N_LINK')

//
// SEGMENT 2 - Inner Path (Up from UCLA to SRI)

ucla.addEdge('N_LINK', ucsb, 'labelE', 'N_LINK')
ucsb.addEdge('N_LINK', sri, 'labelE', 'N_LINK')

//
// SEGMENT 3 - Inner Path (Up from RAND to SRI)

rand.addEdge('N_LINK', stanford, 'labelE', 'N_LINK')
stanford.addEdge('N_LINK', sri, 'labelE', 'N_LINK')

//
// SEGMENT 4 - Inner Path (Up from RAND to UTAH)

rand.addEdge('N_LINK', sdc, 'labelE', 'N_LINK')
sdc.addEdge('N_LINK', utah, 'labelE', 'N_LINK')

//
// SEGMENT 5 - Inner Path (Up from BBN to MIT)

bbn.addEdge('N_LINK', mit, 'labelE', 'N_LINK')
