#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.Graph do

  ## ATTRIBUTES

  @storage_dir GraphCommons.storage_dir()

  ## STRUCT

  @derive {Inspect, except: [:path, :uri]}

  @enforce_keys ~w[data file type]a
  defstruct ~w[data file path type uri]a

  ## TYPES

  @type graph_data :: String.t()
  @type graph_file :: String.t()
  @type graph_path :: String.t()
  @type graph_type :: GraphCommons.graph_type()
  @type graph_uri :: String.t()

  @type t :: %__MODULE__{
          # user
          data: graph_data,
          file: graph_file,
          type: graph_type,
          # system
          path: graph_path,
          uri: graph_uri
        }

  defguard is_graph_type(graph_type)
           when graph_type in [ :dgraph, :native, :property, :rdf, :tinker ]

  ## CONSTRUCTOR

  def new(graph_data, graph_file, graph_type)
      when is_graph_type(graph_type) do
    graph_path = "#{@storage_dir}/#{graph_type}/graphs/#{graph_file}"

    %__MODULE__{
      # user
      data: graph_data,
      file: graph_file,
      type: graph_type,
      # system
      path: graph_path,
      uri: "file://" <> graph_path
    }
  end

  ## FUNCTIONS

  def graphs_dir(graph_type), do: "#{@storage_dir}/#{graph_type}/graphs/"

  @type file_test :: GraphCommons.file_test()

  def list_graphs(graph_type, file_test \\ :exists?) do
    list_graphs_dir("", graph_type, file_test)
  end

  def list_graphs_dir(graph_file, graph_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{graph_type}/graphs/"

    (path <> graph_file)
    |> File.ls!()
    |> do_filter(path, file_test)
    |> Enum.sort()
    |> Enum.map(fn f ->
      File.dir?(path <> f)
      |> case do
        true -> "#{String.upcase(f)}"
        false -> f
      end
    end)
  end

  defp do_filter(files, path, file_test) do
    files
    |> Enum.filter(fn f ->
      case file_test do
        :dir? -> File.dir?(path <> f)
        :regular? -> File.regular?(path <> f)
        :exists? -> true
      end
    end)
  end

  def read_graph(graph_file, graph_type)
      when graph_file != "" and is_graph_type(graph_type) do
    graphs_dir = "#{@storage_dir}/#{graph_type}/graphs/"
    graph_data = File.read!(graphs_dir <> graph_file)

    new(graph_data, graph_file, graph_type)
  end

  def write_graph(graph_data, graph_file, graph_type)
      when graph_data != "" and
             graph_file != "" and is_graph_type(graph_type) do
    graphs_dir = "#{@storage_dir}/#{graph_type}/graphs/"
    File.write!(graphs_dir <> graph_file, graph_data)

    new(graph_data, graph_file, graph_type)
  end

  ## MACROS

  defmacro __using__(opts) do
    graph_type = Keyword.get(opts, :graph_type)
    graph_module = Keyword.get(opts, :graph_module)

    quote do

      ## TYPES

       @type graph_file_test :: GraphCommons.file_test()

       @type graph_data :: GraphCommons.Graph.graph_data()
       @type graph_file :: GraphCommons.Graph.graph_file()
       @type graph_path :: GraphCommons.Graph.graph_path()
       @type graph_type :: GraphCommons.Graph.graph_type()
       @type graph_uri :: GraphCommons.Graph.graph_uri()

       @type graph_t :: GraphCommons.Graph.t()

       ## FUNCTIONS

       def graph_context(), do: unquote(graph_module)

       def list_graphs(graph_file_test \\ :exists?),
         do: GraphCommons.Graph.list_graphs(
           unquote(graph_type), graph_file_test)

       def list_graphs_dir(dir, graph_file_test \\ :exists?),
         do: GraphCommons.Graph.list_graphs_dir(dir,
           unquote(graph_type), graph_file_test)

       def new_graph(graph_data), do: new_graph(graph_data, "")

       def new_graph(graph_data, graph_file),
         do: GraphCommons.Graph.new(graph_data, graph_file,
           unquote(graph_type))

       def read_graph(graph_file),
         do: GraphCommons.Graph.read_graph(graph_file,
           unquote(graph_type))

       def write_graph(graph_data, graph_file),
         do: GraphCommons.Graph.write_graph(graph_data, graph_file,
           unquote(graph_type))
     end
  end

  ## IMPLEMENTATIONS

  defimpl Inspect, for: __MODULE__ do
    @slice 16  
    @quote <<?">>  

    def inspect(%GraphCommons.Graph{} = graph, _opts) do
      type = graph.type
      file = @quote <> graph.file <> @quote

      str =
        graph.data
        |> String.replace("\n", "\\n")  
        |> String.replace(@quote, "\\" <> @quote)  
        |> String.slice(0, @slice)  

      data =
        case String.length(str) < @slice do  
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Graph<type: #{type}, file: #{file}, data: #{data}>"  
    end
  end

end
