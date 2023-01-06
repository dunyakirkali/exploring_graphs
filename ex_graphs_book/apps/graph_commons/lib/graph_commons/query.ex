#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.Query do

  ## ATTRIBUTES

  @storage_dir GraphCommons.storage_dir()

  ## STRUCT

  @derive {Inspect, except: [:path, :uri]}

  @enforce_keys ~w[data file type]a
  defstruct ~w[data file path type uri]a

  ## TYPES

  @type query_data :: String.t()
  @type query_file :: String.t()
  @type query_path :: String.t()
  @type query_type :: GraphCommons.query_type()
  @type query_uri :: String.t()

  @type t :: %__MODULE__{
          # user
          data: query_data,
          file: query_file,
          type: query_type,
          # system
          path: query_path,
          uri: query_uri
        }

  defguard is_query_type(query_type)
           when query_type in [ :dgraph, :native, :property, :rdf, :tinker ]

  ## CONSTRUCTOR

  def new(query_data, query_file, query_type)
      when is_query_type(query_type) do
    query_path = "#{@storage_dir}/#{query_type}/queries/#{query_file}"

    %__MODULE__{
      # user
      data: query_data,
      file: query_file,
      type: query_type,
      # system
      path: query_path,
      uri: "file://" <> query_path
    }
  end

  ## FUNCTIONS

  def queries_dir(query_type), do: "#{@storage_dir}/#{query_type}/queries/"

  @type file_test :: GraphCommons.file_test()

  def list_queries(query_type, file_test \\ :exists?) do
    list_queries_dir("", query_type, file_test)
  end

  def list_queries_dir(query_file, query_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{query_type}/queries/"

    (path <> query_file)
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

  def read_query(query_file, query_type)
      when query_file != "" and is_query_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    query_data = File.read!(queries_dir <> query_file)

    new(query_data, query_file, query_type)
  end

  def write_query(query_data, query_file, query_type)
      when query_data != "" and
             query_file != "" and is_query_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    File.write!(queries_dir <> query_file, query_data)

    new(query_data, query_file, query_type)
  end

  ## MACROS

  defmacro __using__(opts) do
    query_type = Keyword.get(opts, :query_type)
    query_module = Keyword.get(opts, :query_module)

    quote do

      ## TYPES

      @type query_file_test :: GraphCommons.file_test()

      @type query_data :: GraphCommons.Query.query_data()
      @type query_file :: GraphCommons.Query.query_file()
      @type query_path :: GraphCommons.Query.query_path()
      @type query_type :: GraphCommons.Query.query_type()
      @type query_uri :: GraphCommons.Query.query_uri()

      @type query_t :: GraphCommons.Query.t()

      ## FUNCTIONS

      def query_context(), do: unquote(query_module)

      def list_queries(query_file_test \\ :exists?),
        do: GraphCommons.Query.list_queries(
          unquote(query_type), query_file_test)

      def list_queries_dir(dir, query_file_test \\ :exists?),
        do: GraphCommons.Query.list_queries_dir(dir,
          unquote(query_type), query_file_test)

      def new_query(query_data), do: new_query(query_data, "")

      def new_query(query_data, query_file),
        do: GraphCommons.Query.new(query_data, query_file,
          unquote(query_type))

      def read_query(query_file),
        do: GraphCommons.Query.read_query(query_file,
          unquote(query_type))

      def write_query(query_data, query_file),
        do: GraphCommons.Query.write_query(query_data, query_file,
          unquote(query_type))
    end
  end

  ## IMPLEMENTATIONS

  defimpl Inspect, for: __MODULE__ do
    @slice 16
    @quote <<?">>

    def inspect(%GraphCommons.Query{} = query, _opts) do
      type = query.type
      file = @quote <> query.file <> @quote

      str =
        query.data
        |> String.replace("\n", "\\n")
        |> String.replace(@quote, "\\" <> @quote)
        |> String.slice(0, @slice)

      data =
        case String.length(str) < @slice do
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Query<type: #{type}, file: #{file}, data: #{data}>"
    end
  end

end
