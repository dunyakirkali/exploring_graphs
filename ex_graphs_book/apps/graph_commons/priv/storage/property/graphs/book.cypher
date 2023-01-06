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

;
