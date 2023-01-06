/***
 * Excerpted from "Exploring Graphs with Elixir",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit https://pragprog.com/titles/thgraphs for more book information.
***/
// Books graph

// Book 1
adopting_elixir = graph.addVertex(label, 'Book',
  'id', 'adopting_elixir',
  'date', '2018-03-14',
  'format', 'Paper',
  'isbn', '978-1-68050-252-7',
  'title', 'Adopting Elixir',
  'url', 'https://pragprog.com/titles/tvmelixir/adopting-elixir/',
)
ben_marx = graph.addVertex(label, 'Author',
  'id', 'ben_marx',
  'name', 'Ben Marx',
  'url', 'https://twitter.com/bgmarx',
)
jose_valim = graph.addVertex(label, 'Author',
  'id', 'jose_valim',
  'name', 'José Valim',
  'url', 'https://twitter.com/josevalim',
)
bruce_tate = graph.addVertex(label, 'Author',
  'id', 'bruce_tate',
  'name', 'Bruce Tate',
  'url', 'https://twitter.com/redrapids',
)
pragmatic = graph.addVertex(label, 'Publisher',
  'id', 'pragmatic',
  'name', 'The Pragmatic Bookshelf',
  'url', 'https://pragprog.com/',
)

// add  edges
adopting_elixir.addEdge('AUTHOR', ben_marx,
  'role', 'first author',
)
adopting_elixir.addEdge('AUTHOR', jose_valim,
  'role', 'second author',
)
adopting_elixir.addEdge('AUTHOR', bruce_tate,
  'role', 'third author',
)
adopting_elixir.addEdge('PUBLISHER', pragmatic,
)
pragmatic.addEdge('BOOK', adopting_elixir,
)

// Book 2
craft_graphql = graph.addVertex(label, 'Book',
  'id', 'craft_graphql',
  'date', '2018-03-27',
  'format', 'Paper',
  'isbn', '978-1-68050-255-8',
  'title', 'Craft GraphQL APIs in Elixir with Absinthe',
  'url', 'https://pragprog.com/titles/wwgraphql/craft-graphql-apis-in-elixir-with-absinthe/',
)
bruce_williams = graph.addVertex(label, 'Author',
  'id', 'bruce_williams',
  'name', 'Bruce Williams',
  'url', 'https://twitter.com/wbruce',
)
ben_wilson = graph.addVertex(label, 'Author',
  'id', 'ben_wilson',
  'name', 'Ben Wilson',
  'url', 'https://twitter.com/benwilson512',
)

// add  edges
craft_graphql.addEdge('AUTHOR', bruce_williams,
  'role', 'first author',
)
craft_graphql.addEdge('AUTHOR', ben_wilson,
  'role', 'second author',
)
craft_graphql.addEdge('PUBLISHER', pragmatic,
)
pragmatic.addEdge('BOOK', craft_graphql,
)

// Book 3
designing_elixir = graph.addVertex(label, 'Book',
  'id', 'designing_elixir',
  'date', '2019-11-20',
  'format', 'Paper',
  'isbn', '978-1-68050-661-7',
  'title', 'Designing Elixir Systems with OTP',
  'url', 'https://pragprog.com/titles/jgotp/designing-elixir-systems-with-otp/',
)
james_gray = graph.addVertex(label, 'Author',
  'id', 'james_gray',
  'name', 'James Edward Gray II',
  'url', 'https://twitter.com/JEG2',
)

// add  edges
designing_elixir.addEdge('AUTHOR', james_gray,
  'role', 'first author',
)

designing_elixir.addEdge('AUTHOR', bruce_tate,
  'role', 'second author',
)
designing_elixir.addEdge('PUBLISHER', pragmatic,
)
pragmatic.addEdge('BOOK', designing_elixir,
)


// Book 4
graph_algorithms = graph.addVertex(label, 'Book',
  'id', 'graph_algorithms',
  'date', '2018-03-14',
  'format', 'Paper',
  'isbn', '978-1-68050-252-7',
  'title', 'Graph Algorithms',
  'url', 'https://www.oreilly.com/library/view/graph-algorithms/9781492047674/',
)
amy_hodler = graph.addVertex(label, 'Author',
  'id', 'amy_hodler',
  'name', 'Amy E. Hodler',
  'url', 'https://twitter.com/amyhodler',
)
mark_needham = graph.addVertex(label, 'Author',
  'id', 'Author',
  'name', 'Mark Needham',
  'url', 'https://twitter.com/markhneedham',
)
oreilly = graph.addVertex(label, 'Publisher',
  'id', 'oreilly',
  'name', 'O\'Reilly Media',
  'url', 'https://www.oreilly.com/',
)

// add  edges
graph_algorithms.addEdge('AUTHOR', amy_hodler,
  'role', 'first author',
)
graph_algorithms.addEdge('AUTHOR', mark_needham,
  'role', 'second author',
)
graph_algorithms.addEdge('PUBLISHER', oreilly,
)
oreilly.addEdge('BOOK', graph_algorithms,
)
