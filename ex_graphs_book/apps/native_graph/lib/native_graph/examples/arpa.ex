#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule NativeGraph.Examples.Arpa do

  def arpa do

    ## GRAPH

    g = Graph.new(type: :undirected)

    ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SRI)

    # Site: UCLA
    g =
      g
      |> Graph.add_vertex(:ucla, "UCLA")
      |> Graph.add_vertex(:ucla_h1, "SIGMA7")
      |> Graph.add_edge(:ucla_h1, :ucla)

    # Site: UCSB
    g =
      g
      |> Graph.add_vertex(:ucsb, "UCSB")
      |> Graph.add_vertex(:ucsb_h1, "360")
      |> Graph.add_edge(:ucsb_h1, :ucsb)

    # Site: SRI
    g =
      g
      |> Graph.add_vertex(:sri, "SRI")
      |> Graph.add_vertex(:sri_h1, "940")
      |> Graph.add_edge(:sri_h1, :sri)

    ##
    ## SEGMENT 2 - Inner Path (Right from SRI to UTAH)

    # Site: UTAH
    g =
      g
      |> Graph.add_vertex(:utah, "UTAH")
      |> Graph.add_vertex(:utah_h1, "PDP-10")
      |> Graph.add_edge(:utah_h1, :utah)

    ##
    ## NETWORK (3+1=4)

    g =
      g
      ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SRI)
      |> Graph.add_edge(:ucla, :ucsb)
      |> Graph.add_edge(:ucsb, :sri)
      |> Graph.add_edge(:sri, :ucla)
      ## SEGMENT 2 - Inner Path (Right from SRI to UTAH)
      |> Graph.add_edge(:sri, :utah)

    # add reversed edges
    g =
      g
      |> Graph.edges()
      |> Enum.reduce(g, fn %{v1: v1, v2: v2, label: label} = _e, g ->
        Graph.add_edge(g, v2, v1, label: label)
      end)
    g
  end

  def arpa69(use_id? \\ true) do
    ####
    # ARPANET - Dec 1969 [1]
    #
    # [1] https://www.scientificamerican.com/gallery/early-sketch-of-arpanets-first-four-nodes/
    ####

    use_label? = false

    # function to select id/map based on use_id? setting
    val = fn map -> if use_id?, do: map.id, else: map end
    # function to select label/map based on use_type? setting
    lab = fn map -> if use_label?, do: map.label, else: map end

    ####

    ##
    ## GRAPH

    g = Graph.new(type: :undirected)

    ##
    ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SRI)

    # Site: UCLA

    ucla = %{id: :ucla, label: "Node", type: "IMP", name: "UCLA"}

    ucla_h1 = %{id: :ucla_h1, label: "Host", name: "SIGMA7"}

    g =
      g
      |> Graph.add_vertex(val.(ucla), lab.(ucla))
      |> Graph.add_vertex(val.(ucla_h1), lab.(ucla_h1))
      |> Graph.add_edge(val.(ucla_h1), val.(ucla))

    # Site: UCSB

    ucsb = %{id: :ucsb, label: "Node", type: "IMP", name: "UCSB"}

    ucsb_h1 = %{id: :ucsb_h1, label: "Host", name: "360"}

    g =
      g
      |> Graph.add_vertex(val.(ucsb), lab.(ucsb))
      |> Graph.add_vertex(val.(ucsb_h1), lab.(ucsb_h1))
      |> Graph.add_edge(val.(ucsb_h1), val.(ucsb))

    # Site: SRI

    sri = %{id: :sri, label: "Node", type: "IMP", name: "SRI"}

    sri_h1 = %{id: :sri_h1, label: "Host", name: "940"}

    g =
      g
      |> Graph.add_vertex(val.(sri), lab.(sri))
      |> Graph.add_vertex(val.(sri_h1), lab.(sri_h1))
      |> Graph.add_edge(val.(sri_h1), val.(sri))

    ##
    ## SEGMENT 2 - Inner Path (Right from SRI to UTAH)

    # Site: UTAH

    utah = %{id: :utah, label: "Node", type: "IMP", name: "UTAH"}

    utah_h1 = %{id: :utah_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(utah), lab.(utah))
      |> Graph.add_vertex(val.(utah_h1), lab.(utah_h1))
      |> Graph.add_edge(val.(utah_h1), val.(utah))

    ##
    ## NETWORK (3+1=4)

    g =
      g
      ##
      ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SRI)
      |> Graph.add_edge(val.(ucla), val.(ucsb))
      |> Graph.add_edge(val.(ucsb), val.(sri))
      |> Graph.add_edge(val.(sri), val.(ucla))
      ##
      ## SEGMENT 2 - Inner Path (Right from SRI to UTAH)
      |> Graph.add_edge(val.(sri), val.(utah))

    ####

    # add reversed edges
    g =
      g
      |> Graph.edges()
      |> Enum.reduce(g, fn %{v1: v1, v2: v2, label: label} = _e, g ->
        Graph.add_edge(g, v2, v1, label: label)
      end)
    g
  end

  def arpa70(use_id? \\ true) do
    ####
    # ARPANET - Dec 1970 [1]
    #
    # [1] http://mercury.lcs.mit.edu/~jnc/tech/arpalog.html
    ####

    use_label? = false

    # function to select id/map based on use_id? setting
    val = fn map -> if use_id?, do: map.id, else: map end
    # function to select type/map based on use_type? setting
    lab = fn map -> if use_label?, do: map.label, else: map end

    ####

    ##
    ## GRAPH

    g = Graph.new(type: :undirected)

    ##
    ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)

    # Site: UCLA

    ucla = %{id: :ucla, label: "Node", type: "IMP", name: "UCLA"}

    ucla_h1 = %{id: :ucla_h1, label: "Host", name: "360/91"}
    ucla_h2 = %{id: :ucla_h2, label: "Host", name: "XDS SIGMA7"}

    g =
      g
      |> Graph.add_vertex(val.(ucla), lab.(ucla))
      |> Graph.add_vertex(val.(ucla_h1), lab.(ucla_h1))
      |> Graph.add_vertex(val.(ucla_h2), lab.(ucla_h2))
      |> Graph.add_edge(val.(ucla_h1), val.(ucla))
      |> Graph.add_edge(val.(ucla_h2), val.(ucla))

    # Site: SRI

    sri = %{id: :sri, label: "Node", type: "IMP", name: "SRI"}

    sri_h1 = %{id: :sri_h1, label: "Host", name: "PDP-10"}
    sri_h2 = %{id: :sri_h2, label: "Host", name: "XDS-940"}

    g =
      g
      |> Graph.add_vertex(val.(sri), lab.(sri))
      |> Graph.add_vertex(val.(sri_h1), lab.(sri_h1))
      |> Graph.add_vertex(val.(sri_h2), lab.(sri_h2))
      |> Graph.add_edge(val.(sri_h1), val.(sri))
      |> Graph.add_edge(val.(sri_h2), val.(sri))

    # Site: UTAH

    utah = %{id: :utah, label: "Node", type: "IMP", name: "UTAH"}

    utah_h1 = %{id: :utah_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(utah), lab.(utah))
      |> Graph.add_vertex(val.(utah_h1), lab.(utah_h1))
      |> Graph.add_edge(val.(utah_h1), val.(utah))

    # Site: MIT

    mit = %{id: :mit, label: "Node", type: "IMP", name: "MIT"}

    mit_h1 = %{id: :mit_h1, label: "Host", name: "PDP-10"}
    mit_h2 = %{id: :mit_h2, label: "Host", name: "PDP-10"}
    mit_h3 = %{id: :mit_h3, label: "Host", name: "GE-645"}

    g =
      g
      |> Graph.add_vertex(val.(mit), lab.(mit))
      |> Graph.add_vertex(val.(mit_h1), lab.(mit_h1))
      |> Graph.add_vertex(val.(mit_h2), lab.(mit_h2))
      |> Graph.add_vertex(val.(mit_h3), lab.(mit_h3))
      |> Graph.add_edge(val.(mit_h1), val.(mit))
      |> Graph.add_edge(val.(mit_h2), val.(mit))
      |> Graph.add_edge(val.(mit_h3), val.(mit))

    # Site: LINCOLN

    lincoln = %{id: :lincoln, label: "Node", type: "IMP", name: "LINCOLN"}

    lincoln_h1 = %{id: :lincoln_h1, label: "Host", name: "360/67"}
    lincoln_h2 = %{id: :lincoln_h2, label: "Host", name: "TX2"}
    lincoln_h3 = %{id: :lincoln_h3, label: "Host", name: "TSP"}

    g =
      g
      |> Graph.add_vertex(val.(lincoln), lab.(lincoln))
      |> Graph.add_vertex(val.(lincoln_h1), lab.(lincoln_h1))
      |> Graph.add_vertex(val.(lincoln_h2), lab.(lincoln_h2))
      |> Graph.add_vertex(val.(lincoln_h3), lab.(lincoln_h3))
      |> Graph.add_edge(val.(lincoln_h1), val.(lincoln))
      |> Graph.add_edge(val.(lincoln_h2), val.(lincoln))
      |> Graph.add_edge(val.(lincoln_h3), val.(lincoln))

    # Site: CASE

    case = %{id: :case, label: "Node", type: "IMP", name: "CASE"}

    case_h1 = %{id: :case_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(case), lab.(case))
      |> Graph.add_vertex(val.(case_h1), lab.(case_h1))
      |> Graph.add_edge(val.(case_h1), val.(case))

    # Site: CARNEGIE

    carnegie = %{id: :carnegie, label: "Node", type: "IMP", name: "CARNEGIE"}

    carnegie_h1 = %{id: :carnegie_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(carnegie), lab.(carnegie))
      |> Graph.add_vertex(val.(carnegie_h1), lab.(carnegie_h1))
      |> Graph.add_edge(val.(carnegie_h1), val.(carnegie))

    # Site: HARVARD

    harvard = %{id: :harvard, label: "Node", type: "IMP", name: "HARVARD"}

    harvard_h1 = %{id: :harvard_h1, label: "Host", name: "PDP-1"}
    harvard_h2 = %{id: :harvard_h2, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(harvard), lab.(harvard))
      |> Graph.add_vertex(val.(harvard_h1), lab.(harvard_h1))
      |> Graph.add_vertex(val.(harvard_h2), lab.(harvard_h2))
      |> Graph.add_edge(val.(harvard_h1), val.(harvard))
      |> Graph.add_edge(val.(harvard_h2), val.(harvard))

    # Site: BBN

    bbn = %{id: :bbn, label: "Node", type: "IMP", name: "BBN"}

    bbn_h1 = %{id: :bbn_h1, label: "Host", name: "DDP-516"}
    bbn_h2 = %{id: :bbn_h2, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(bbn), lab.(bbn))
      |> Graph.add_vertex(val.(bbn_h1), lab.(bbn_h1))
      |> Graph.add_vertex(val.(bbn_h2), lab.(bbn_h2))
      |> Graph.add_edge(val.(bbn_h1), val.(bbn))
      |> Graph.add_edge(val.(bbn_h2), val.(bbn))

    # Site: RAND

    rand = %{id: :rand, label: "Node", type: "IMP", name: "RAND"}

    rand_h1 = %{id: :rand_h1, label: "Host", name: "IBM 1800", user: "360/65"}

    g =
      g
      |> Graph.add_vertex(val.(rand), lab.(rand))
      |> Graph.add_vertex(val.(rand_h1), lab.(rand_h1))
      |> Graph.add_edge(val.(rand_h1), val.(rand))

    ##
    ## SEGMENT 2 - Outer Path (Up from UCLA to SRI)

    # Site: UCSB

    ucsb = %{id: :ucsb, label: "Node", type: "IMP", name: "UCSB"}

    ucsb_h1 = %{id: :ucsb_h1, label: "Host", name: "360/75"}

    g =
      g
      |> Graph.add_vertex(val.(ucsb), lab.(ucsb))
      |> Graph.add_vertex(val.(ucsb_h1), lab.(ucsb_h1))
      |> Graph.add_edge(val.(ucsb_h1), val.(ucsb))

    ##
    ## SEGMENT 3 - Inner Path (Up from RAND to SRI)

    # Site: STANFORD

    stanford = %{id: :stanford, label: "Node", type: "IMP", name: "STANFORD"}

    stanford_h1 = %{id: :stanford_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(stanford), lab.(stanford))
      |> Graph.add_vertex(val.(stanford_h1), lab.(stanford_h1))
      |> Graph.add_edge(val.(stanford_h1), val.(stanford))

    ##
    ## SEGMENT 4 - Inner Path (Up from RAND to UTAH)

    # Site: SDC

    sdc = %{id: :sdc, label: "Node", type: "IMP", name: "SDC"}

    sdc_h1 = %{id: :sdc_h1, label: "Host", name: "DDP-516", user: "360/67"}

    g =
      g
      |> Graph.add_vertex(val.(sdc), lab.(sdc))
      |> Graph.add_vertex(val.(sdc_h1), lab.(sdc_h1))
      |> Graph.add_edge(val.(sdc_h1), val.(sdc))

    ##
    ## SEGMENT 5 - Inner Path (Up from BBN to MIT)

    ##
    ## NETWORK (10+2+2+2+1=17)

    g =
      g
      ##
      ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)
      |> Graph.add_edge(val.(ucla), val.(sri))
      |> Graph.add_edge(val.(sri), val.(utah))
      |> Graph.add_edge(val.(utah), val.(mit))
      |> Graph.add_edge(val.(mit), val.(lincoln))
      |> Graph.add_edge(val.(lincoln), val.(case))
      |> Graph.add_edge(val.(case), val.(carnegie))
      |> Graph.add_edge(val.(carnegie), val.(harvard))
      |> Graph.add_edge(val.(harvard), val.(bbn))
      |> Graph.add_edge(val.(bbn), val.(rand))
      |> Graph.add_edge(val.(rand), val.(ucla))
      ##
      ## SEGMENT 2 - Outer Path (Up from UCLA to SRI)
      |> Graph.add_edge(val.(ucla), val.(ucsb))
      |> Graph.add_edge(val.(ucsb), val.(sri))
      ##
      ## SEGMENT 3 - Inner Path (Up from RAND to SRI)
      |> Graph.add_edge(val.(rand), val.(stanford))
      |> Graph.add_edge(val.(stanford), val.(sri))
      ##
      ## SEGMENT 4 - Inner Path (Up from RAND to UTAH)
      |> Graph.add_edge(val.(rand), val.(sdc))
      |> Graph.add_edge(val.(sdc), val.(utah))
      ##
      ## SEGMENT 5 - Inner Path (Up from BBN to MIT)
      |> Graph.add_edge(val.(bbn), val.(mit))

    ####

    # add reversed edges
    g =
      g
      |> Graph.edges()
      |> Enum.reduce(g, fn %{v1: v1, v2: v2, label: label} = _e, g ->
        Graph.add_edge(g, v2, v1, label: label)
      end)
    g
  end

  def arpa72(use_id? \\ true) do
    ####
    # ARPANET - Dec 1972 [1,2]
    #
    # [1] RFC-432, N. Neigus (BBN), https://tools.ietf.org/pdf/rfc432.pdf
    # [2] http://mercury.lcs.mit.edu/~jnc/tech/arpalog.html
    ####

    use_label? = false

    # function to select id/map based on use_id? setting
    val = fn map -> if use_id?, do: map.id, else: map end
    # function to select type/map based on use_type? setting
    lab = fn map -> if use_label?, do: map.label, else: map end

    ####

    ##
    ## GRAPH

    g = Graph.new(type: :undirected)

    ##
    ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SDC)

    # Site: UCLA

    ucla = %{id: :ucla, label: "Node", type: "IMP", name: "UCLA"}

    ucla_h1 = %{id: :ucla_h1, label: "Host", name: "360/91"}
    ucla_h2 = %{id: :ucla_h2, label: "Host", name: "SIGMA-7"}

    g =
      g
      |> Graph.add_vertex(val.(ucla), lab.(ucla))
      |> Graph.add_vertex(val.(ucla_h1), lab.(ucla_h1))
      |> Graph.add_vertex(val.(ucla_h2), lab.(ucla_h2))
      |> Graph.add_edge(val.(ucla_h1), val.(ucla))
      |> Graph.add_edge(val.(ucla_h2), val.(ucla))

    # Site: UCSB

    ucsb = %{id: :ucsb, label: "Node", type: "IMP", name: "UCSB"}

    ucsb_h1 = %{id: :ucsb_h1, label: "Host", name: "360/75"}

    g =
      g
      |> Graph.add_vertex(val.(ucsb), lab.(ucsb))
      |> Graph.add_vertex(val.(ucsb_h1), lab.(ucsb_h1))
      |> Graph.add_edge(val.(ucsb_h1), val.(ucsb))

    # Site: FNWC

    fnwc = %{id: :fnwc, label: "Node", type: "TIP", name: "FNWC"}

    g =
      g
      |> Graph.add_vertex(val.(fnwc), lab.(fnwc))

    # Site: XEROX

    xerox = %{id: :xerox, label: "Node", type: "316 IMP", name: "XEROX"}

    g =
      g
      |> Graph.add_vertex(val.(xerox), lab.(xerox))

    # Site: SRI

    sri = %{id: :sri, label: "Node", type: "IMP", name: "SRI"}

    sri_h1 = %{id: :sri_h1, label: "Host", name: "PDP-10"}
    sri_h2 = %{id: :sri_h2, label: "Host", name: "PDP-15", user: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(sri), lab.(sri))
      |> Graph.add_vertex(val.(sri_h1), lab.(sri_h1))
      |> Graph.add_vertex(val.(sri_h2), lab.(sri_h2))
      |> Graph.add_edge(val.(sri_h1), val.(sri))
      |> Graph.add_edge(val.(sri_h2), val.(sri))

    # Site: UTAH

    utah = %{id: :utah, label: "Node", type: "IMP", name: "UTAH"}

    utah_h1 = %{id: :utah_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(utah), lab.(utah))
      |> Graph.add_vertex(val.(utah_h1), lab.(utah_h1))
      |> Graph.add_edge(val.(utah_h1), val.(utah))

    # Site: ILLINOIS

    illinois = %{id: :illinois, label: "Node", type: "IMP", name: "ILLINOIS"}

    illinois_h1 = %{id: :illinois_h1, label: "Host", name: "PDP-11"}

    g =
      g
      |> Graph.add_vertex(val.(illinois), lab.(illinois))
      |> Graph.add_vertex(val.(illinois_h1), lab.(illinois_h1))
      |> Graph.add_edge(val.(illinois_h1), val.(illinois))

    # Site: MIT

    mit = %{id: :mit, label: "Node", type: "IMP", name: "MIT"}

    mit_h1 = %{id: :mit_h1, label: "Host", name: "PDP-10"}
    mit_h2 = %{id: :mit_h2, label: "Host", name: "PDP-10"}
    mit_h3 = %{id: :mit_h3, label: "Host", name: "PDP-10"}
    mit_h4 = %{id: :mit_h4, label: "Host", name: "H-645"}

    g =
      g
      |> Graph.add_vertex(val.(mit), lab.(mit))
      |> Graph.add_vertex(val.(mit_h1), lab.(mit_h1))
      |> Graph.add_vertex(val.(mit_h2), lab.(mit_h2))
      |> Graph.add_vertex(val.(mit_h3), lab.(mit_h3))
      |> Graph.add_vertex(val.(mit_h4), lab.(mit_h4))
      |> Graph.add_edge(val.(mit_h1), val.(mit))
      |> Graph.add_edge(val.(mit_h2), val.(mit))
      |> Graph.add_edge(val.(mit_h3), val.(mit))
      |> Graph.add_edge(val.(mit_h4), val.(mit))

    # Site: LINCOLN

    lincoln = %{id: :lincoln, label: "Node", type: "IMP", name: "LINCOLN"}

    lincoln_h1 = %{id: :lincoln_h1, label: "Host", name: "360/67"}
    lincoln_h2 = %{id: :lincoln_h2, label: "Host", name: "TX-2"}
    lincoln_h3 = %{id: :lincoln_h3, label: "Host", name: "TSP"}

    g =
      g
      |> Graph.add_vertex(val.(lincoln), lab.(lincoln))
      |> Graph.add_vertex(val.(lincoln_h1), lab.(lincoln_h1))
      |> Graph.add_vertex(val.(lincoln_h2), lab.(lincoln_h2))
      |> Graph.add_vertex(val.(lincoln_h3), lab.(lincoln_h3))
      |> Graph.add_edge(val.(lincoln_h1), val.(lincoln))
      |> Graph.add_edge(val.(lincoln_h2), val.(lincoln))
      |> Graph.add_edge(val.(lincoln_h3), val.(lincoln))

    # Site: RADC

    radc = %{id: :radc, label: "Node", type: "TIP", name: "RADC"}

    g =
      g
      |> Graph.add_vertex(val.(radc), lab.(radc))

    # Site: CASE

    case = %{id: :case, label: "Node", type: "IMP", name: "CASE"}

    case_h1 = %{id: :case_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(case), lab.(case))
      |> Graph.add_vertex(val.(case_h1), lab.(case_h1))
      |> Graph.add_edge(val.(case_h1), val.(case))

    # Site: GWC

    gwc = %{id: :gwc, label: "Node", type: "TIP", name: "GWC"}

    g =
      g
      |> Graph.add_vertex(val.(gwc), lab.(gwc))

    # Site: DOCB

    docb = %{id: :docb, label: "Node", type: "TIP", name: "DOCB"}

    g =
      g
      |> Graph.add_vertex(val.(docb), lab.(docb))

    # Site: USC

    usc = %{id: :usc, label: "Node", type: "TIP", name: "USC"}

    usc_h1 = %{id: :usc_h1, label: "Host", name: "360/44"}

    g =
      g
      |> Graph.add_vertex(val.(usc), lab.(usc))
      |> Graph.add_vertex(val.(usc_h1), lab.(usc_h1))
      |> Graph.add_edge(val.(usc_h1), val.(usc))

    # Site: SDC

    sdc = %{id: :sdc, label: "Node", type: "IMP", name: "SDC"}

    sdc_h1 = %{id: :sdc_h1, label: "Host", name: "DDP-516", user: "370/145"}

    g =
      g
      |> Graph.add_vertex(val.(sdc), lab.(sdc))
      |> Graph.add_vertex(val.(sdc_h1), lab.(sdc_h1))
      |> Graph.add_edge(val.(sdc_h1), val.(sdc))

    ##
    ## SEGMENT 2 - Inner Path (Up from UCLA to SRI)

    # Site: UCSD

    ucsd = %{id: :ucsd, label: "Node", type: "316 IMP", name: "UCSD"}

    ucsd_h1 = %{id: :ucsd_h1, label: "Host", name: "MICRO 810", user: "B6700"}

    g =
      g
      |> Graph.add_vertex(val.(ucsd), lab.(ucsd))
      |> Graph.add_vertex(val.(ucsd_h1), lab.(ucsd_h1))
      |> Graph.add_edge(val.(ucsd_h1), val.(ucsd))

    # Site: RAND

    rand = %{id: :rand, label: "Node", type: "316 IMP", name: "RAND"}

    rand_h1 = %{id: :rand_h1, label: "Host", name: "IBM 1800", user: "360/65"}

    g =
      g
      |> Graph.add_vertex(val.(rand), lab.(rand))
      |> Graph.add_vertex(val.(rand_h1), lab.(rand_h1))
      |> Graph.add_edge(val.(rand_h1), val.(rand))

    # Site: USC-ISI

    usc_isi = %{id: :usc_isi, label: "Node", type: "IMP", name: "USC-ISI"}

    usc_isi_h1 = %{id: :usc_isi_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(usc_isi), lab.(usc_isi))
      |> Graph.add_vertex(val.(usc_isi_h1), lab.(usc_isi_h1))
      |> Graph.add_edge(val.(usc_isi_h1), val.(usc_isi))

    # Site: STANFORD

    stanford = %{id: :stanford, label: "Node", type: "IMP", name: "STANFORD"}

    stanford_h1 = %{id: :stanford_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(stanford), lab.(stanford))
      |> Graph.add_vertex(val.(stanford_h1), lab.(stanford_h1))
      |> Graph.add_edge(val.(stanford_h1), val.(stanford))

    # Site: AMES (IMP)

    ames = %{id: :ames, label: "Node", type: "IMP", name: "AMES"}

    ames_h1 = %{id: :ames_h1, label: "Host", name: "PDP-10"}
    ames_h2 = %{id: :ames_h2, label: "Host", name: "PDP-11"}

    g =
      g
      |> Graph.add_vertex(val.(ames), lab.(ames))
      |> Graph.add_vertex(val.(ames_h1), lab.(ames_h1))
      |> Graph.add_vertex(val.(ames_h2), lab.(ames_h2))
      |> Graph.add_edge(val.(ames_h1), val.(ames))
      |> Graph.add_edge(val.(ames_h2), val.(ames))

    # Site: AMES (TIP)

    ames1 = %{id: :ames1, label: "Node", type: "TIP", name: "AMES"}

    ames1_h1 = %{id: :ames1_h1, label: "Host", name: "360-67"}

    g =
      g
      |> Graph.add_vertex(val.(ames1), lab.(ames1))
      |> Graph.add_vertex(val.(ames1_h1), lab.(ames1_h1))
      |> Graph.add_edge(val.(ames1_h1), val.(ames1))

    ##
    ## SEGMENT 3 - Inner Path (Up from CASE to MIT)

    # Site: CARNEGIE

    carnegie = %{id: :carnegie, label: "Node", type: "IMP", name: "CARNEGIE"}

    carnegie_h1 = %{id: :carnegie_h1, label: "Host", name: "PDP-10"}
    carnegie_h2 = %{id: :carnegie_h2, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(carnegie), lab.(carnegie))
      |> Graph.add_vertex(val.(carnegie_h1), lab.(carnegie_h1))
      |> Graph.add_vertex(val.(carnegie_h2), lab.(carnegie_h2))
      |> Graph.add_edge(val.(carnegie_h1), val.(carnegie))
      |> Graph.add_edge(val.(carnegie_h2), val.(carnegie))

    # Site: BELVOIR

    belvoir = %{id: :belvoir, label: "Node", type: "316 IMP", name: "BELVOIR"}

    g =
      g
      |> Graph.add_vertex(val.(belvoir), lab.(belvoir))

    # Site: SAAC

    saac = %{id: :saac, label: "Node", type: "TIP", name: "SAAC"}

    g =
      g
      |> Graph.add_vertex(val.(saac), lab.(saac))

    # Site: MITRE

    mitre = %{id: :mitre, label: "Node", type: "TIP", name: "MITRE"}

    g =
      g
      |> Graph.add_vertex(val.(mitre), lab.(mitre))

    # Site: ARPA

    arpa = %{id: :arpa, label: "Node", type: "TIP", name: "ARPA"}

    arpa_h1 = %{id: :arpa_h1, label: "Host", name: "PDP-15"}

    g =
      g
      |> Graph.add_vertex(val.(arpa), lab.(arpa))
      |> Graph.add_vertex(val.(arpa_h1), lab.(arpa_h1))
      |> Graph.add_edge(val.(arpa_h1), val.(arpa))

    # Site: ETAC

    etac = %{id: :etac, label: "Node", type: "TIP", name: "ETAC"}

    g =
      g
      |> Graph.add_vertex(val.(etac), lab.(etac))

    # Site: NBS

    nbs = %{id: :nbs, label: "Node", type: "TIP", name: "NBS"}

    nbs_h1 = %{id: :nbs_h1, label: "Host", name: "PDP-11"}

    g =
      g
      |> Graph.add_vertex(val.(nbs), lab.(nbs))
      |> Graph.add_vertex(val.(nbs_h1), lab.(nbs_h1))
      |> Graph.add_edge(val.(nbs_h1), val.(nbs))

    # Site: ABERDEEN

    aberdeen = %{id: :aberdeen, label: "Node", type: "316 IMP", name: "ABERDEEN"}

    g =
      g
      |> Graph.add_vertex(val.(aberdeen), lab.(aberdeen))

    # Site: HARVARD

    harvard = %{id: :harvard, label: "Node", type: "IMP", name: "HARVARD"}

    harvard_h1 = %{id: :harvard_h1, label: "Host", name: "PDP-1"}
    harvard_h2 = %{id: :harvard_h2, label: "Host", name: "PDP-10"}
    harvard_h3 = %{id: :harvard_h3, label: "Host", name: "PDP-11"}

    g =
      g
      |> Graph.add_vertex(val.(harvard), lab.(harvard))
      |> Graph.add_vertex(val.(harvard_h1), lab.(harvard_h1))
      |> Graph.add_vertex(val.(harvard_h2), lab.(harvard_h2))
      |> Graph.add_vertex(val.(harvard_h3), lab.(harvard_h3))
      |> Graph.add_edge(val.(harvard_h1), val.(harvard))
      |> Graph.add_edge(val.(harvard_h2), val.(harvard))
      |> Graph.add_edge(val.(harvard_h3), val.(harvard))

    # Site: BBN (IMP)

    bbn = %{id: :bbn, label: "Node", type: "IMP", name: "BBN"}

    bbn_h1 = %{id: :bbn_h1, label: "Host", name: "PDP-1"}
    bbn_h2 = %{id: :bbn_h2, label: "Host", name: "PDP-10"}
    bbn_h3 = %{id: :bbn_h3, label: "Host", name: "PDP-10"}
    bbn_h4 = %{id: :bbn_h4, label: "Host", name: "H-316"}

    g =
      g
      |> Graph.add_vertex(val.(bbn), lab.(bbn))
      |> Graph.add_vertex(val.(bbn_h1), lab.(bbn_h1))
      |> Graph.add_vertex(val.(bbn_h2), lab.(bbn_h2))
      |> Graph.add_vertex(val.(bbn_h3), lab.(bbn_h3))
      |> Graph.add_vertex(val.(bbn_h4), lab.(bbn_h4))
      |> Graph.add_edge(val.(bbn_h1), val.(bbn))
      |> Graph.add_edge(val.(bbn_h2), val.(bbn))
      |> Graph.add_edge(val.(bbn_h3), val.(bbn))
      |> Graph.add_edge(val.(bbn_h4), val.(bbn))

    # Site: BBN (TIP)

    bbn1 = %{id: :bbn1, label: "Node", type: "TIP", name: "BBN"}

    g =
      g
      |> Graph.add_vertex(val.(bbn1), lab.(bbn1))

    ##
    ## SEGMENT 4 - Inner Path (Right from HAWAII to AMES)

    # Site: HAWAII

    hawaii = %{id: :hawaii, label: "Node", type: "TIP", name: "HAWAII"}

    g =
      g
      |> Graph.add_vertex(val.(hawaii), lab.(hawaii))

    ##
    ## SEGMENT 5 - Inner Path (Right from USC-ISI to ETAC)

    # Site: TINKER

    tinker = %{id: :tinker, label: "Node", type: "316 IMP", name: "TINKER"}

    tinker_h1 = %{id: :tinker_h1, label: "Host", name: "UNIVAC 418 III"}

    g =
      g
      |> Graph.add_vertex(val.(tinker), lab.(tinker))
      |> Graph.add_vertex(val.(tinker_h1), lab.(tinker_h1))
      |> Graph.add_edge(val.(tinker_h1), val.(tinker))

    ##
    ## SEGMENT 6 - Inner Path (Right from ABERDEEN to BELVOIR)

    ##
    ## SEGMENT 7 - Inner Path (Right from CCA to BBN)

    # Site: CCA

    cca = %{id: :cca, label: "Node", type: "TIP", name: "CCA"}

    cca_h1 = %{id: :cca_h1, label: "Host", name: "PDP-10"}

    g =
      g
      |> Graph.add_vertex(val.(cca), lab.(cca))
      |> Graph.add_vertex(val.(cca_h1), lab.(cca_h1))
      |> Graph.add_edge(val.(cca_h1), val.(cca))

    ##
    ## NETWORK (15+7+12+1+2+1+1=39)

    g =
      g
      ##
      ## SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SDC)
      |> Graph.add_edge(val.(ucla), val.(ucsb))
      |> Graph.add_edge(val.(ucsb), val.(fnwc))
      |> Graph.add_edge(val.(fnwc), val.(xerox))
      |> Graph.add_edge(val.(xerox), val.(sri))
      |> Graph.add_edge(val.(sri), val.(utah))
      |> Graph.add_edge(val.(utah), val.(illinois))
      |> Graph.add_edge(val.(illinois), val.(mit))
      |> Graph.add_edge(val.(mit), val.(lincoln))
      |> Graph.add_edge(val.(lincoln), val.(radc))
      |> Graph.add_edge(val.(radc), val.(case))
      |> Graph.add_edge(val.(case), val.(gwc))
      |> Graph.add_edge(val.(gwc), val.(docb))
      |> Graph.add_edge(val.(docb), val.(usc))
      |> Graph.add_edge(val.(usc), val.(sdc))
      |> Graph.add_edge(val.(sdc), val.(ucla))
      ##
      ## SEGMENT 2 - Inner Path (Up from UCLA to SRI)
      |> Graph.add_edge(val.(ucla), val.(ucsd))
      |> Graph.add_edge(val.(ucsd), val.(rand))
      |> Graph.add_edge(val.(rand), val.(usc_isi))
      |> Graph.add_edge(val.(usc_isi), val.(stanford))
      |> Graph.add_edge(val.(stanford), val.(ames))
      |> Graph.add_edge(val.(ames), val.(ames1))
      |> Graph.add_edge(val.(ames1), val.(sri))
      ##
      ## SEGMENT 3 - Inner Path (Up from CASE to MIT)
      |> Graph.add_edge(val.(case), val.(carnegie))
      |> Graph.add_edge(val.(carnegie), val.(belvoir))
      |> Graph.add_edge(val.(belvoir), val.(saac))
      |> Graph.add_edge(val.(saac), val.(mitre))
      |> Graph.add_edge(val.(mitre), val.(arpa))
      |> Graph.add_edge(val.(arpa), val.(etac))
      |> Graph.add_edge(val.(etac), val.(nbs))
      |> Graph.add_edge(val.(nbs), val.(aberdeen))
      |> Graph.add_edge(val.(aberdeen), val.(harvard))
      |> Graph.add_edge(val.(harvard), val.(bbn))
      |> Graph.add_edge(val.(bbn), val.(bbn1))
      |> Graph.add_edge(val.(bbn1), val.(mit))
      ##
      ## SEGMENT 4 - Inner Path (Right from HAWAII to AMES)
      |> Graph.add_edge(val.(hawaii), val.(ames), type: "S_LINK")
      ##
      ## SEGMENT 5 - Inner Path (Right from USC-ISI to ETAC)
      |> Graph.add_edge(val.(usc_isi), val.(tinker))
      |> Graph.add_edge(val.(tinker), val.(etac))
      ##
      ## SEGMENT 6 - Inner Path (Right from ABERDEEN to BELVOIR)
      |> Graph.add_edge(val.(aberdeen), val.(belvoir))
      ##
      ## SEGMENT 7 - Inner Path (Right from CCA to BBN)
      |> Graph.add_edge(val.(cca), val.(bbn))

    ####

    # add reversed edges
    #  g = g |> Graph.edges |> Enum.reduce(g, fn %{v1: v1, v2: v2, label: label} = _e, g -> Graph.add_edge(g, v2, v1, label: label) end)
    g
  end

end
