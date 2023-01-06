// book 1
CREATE
(bk1:Book {
    id:  "adopting_elixir",
    date: "2018-03-14",
    format: "Paper",
    isbn: "978-1-68050-252-7",
    title: "Adopting Elixir",
    url: "https://pragprog.com/titles/tvmelixir/adopting-elixir/"
}),
(bk1_au1:Author {
    id: "ben_marx",
    name: "Ben Marx",
    url: "https://twitter.com/bgmarx"
}),
(bk1_au2:Author {
    id: "jose_valim",
    name: "José Valim",
    url: "https://twitter.com/josevalim"
}),
(bk1_au3:Author {
    id: "bruce_tate",
    name: "Bruce Tate",
    url: "https://twitter.com/redrapids"
}),
(bk1_pub:Publisher {
    id: "pragmatic",
    name: "The Pragmatic Bookshelf",
    url: "https://pragprog.com/"
})

CREATE
(bk1)-[:AUTHOR { role: "first author" }]->(bk1_au1),
(bk1)-[:AUTHOR { role: "second author" }]->(bk1_au2),
(bk1)-[:AUTHOR { role: "third author" }]->(bk1_au3),
(bk1)-[:PUBLISHER]->(bk1_pub),
(bk1_pub)-[:BOOK]->(bk1)


// book 2
CREATE
(bk2:Book {
    id:  "graphql_apis",
    date: "2018-03-27",
    format: "Paper",
    isbn: "978-1-68050-255-8",
    title: "Craft GraphQL APIs in Elixir with Absinthe",
    url: "https://pragprog.com/titles/wwgraphql/craft-graphql-apis-in-elixir-with-absinthe/"
}),
(bk2_au1:Author {
    id: "bruce_williams",
    name: "Bruce Williams",
    url: "https://twitter.com/wbruce"
}),
(bk2_au2:Author {
    id: "ben_wilson",
    name: "Ben Wilson",
    url: "https://twitter.com/benwilson512"
}),
(bk2_pub:Publisher {
    id: "pragmatic",
    name: "The Pragmatic Bookshelf",
    url: "https://pragprog.com/"
})

CREATE
(bk2)-[:AUTHOR { role: "first author" }]->(bk2_au1),
(bk2)-[:AUTHOR { role: "second author" }]->(bk2_au2),
(bk2)-[:PUBLISHER]->(bk2_pub),
(bk2_pub)-[:BOOK]->(bk2)


// book 3
CREATE
(bk3:Book {
    id:  "designing_elixir",
    date: "2019-11-20",
    format: "Paper",
    isbn: "978-1-68050-661-7",
    title: "Designing Elixir Systems with OTP",
    url: "https://pragprog.com/titles/jgotp/designing-elixir-systems-with-otp/"
}),
(bk3_au1:Author {
    id: "james_gray",
    name: "James Edward Gray II",
    url: "https://twitter.com/JEG2"
}),
(bk3_au2:Author {
    id: "bruce_tate",
    name: "Bruce Tate",
    url: "https://twitter.com/redrapids"
}),
(bk3_pub:Publisher {
    id: "pragmatic",
    name: "The Pragmatic Bookshelf",
    url: "https://pragprog.com/"
})

CREATE
(bk3)-[:AUTHOR { role: "first author" }]->(bk3_au1),
(bk3)-[:AUTHOR { role: "second author" }]->(bk3_au2),
(bk3)-[:PUBLISHER]->(bk3_pub),
(bk3_pub)-[:BOOK]->(bk3)


// book 4
CREATE
(bk4:Book {
    id:  "graph_algorithms",
    date: "2019-03-16",
    format: "Paper",
    isbn: "978-1-492-04767-4",
    title: "Graph Algorithms",
    url: "https://www.oreilly.com/library/view/graph-algorithms/9781492047674/"
}),
(bk4_au1:Author {
    id: "amy_hodler",
    name: "Amy E. Hodler",
    url: "https://twitter.com/amyhodler"
}),
(bk4_au2:Author {
    id: "mark_needham",
    name: "Mark Needham",
    url: "https://twitter.com/markhneedham"
}),
(bk4_pub:Publisher {
    id: "oreilly",
    name: "O'Reilly Media",
    url: "https://www.oreilly.com/"
})

CREATE
(bk4)-[:AUTHOR { role: "first author" }]->(bk4_au1),
(bk4)-[:AUTHOR { role: "second author" }]->(bk4_au2),
(bk4)-[:PUBLISHER]->(bk4_pub),
(bk4_pub)-[:BOOK]->(bk4)

;
