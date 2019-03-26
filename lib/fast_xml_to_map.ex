  defmodule FastXmlToMap do
  require Record

  Record.defrecord :xmlel, Record.extract(:xmlel, from_lib: "fast_xml/include/fxml.hrl")

  def naive_map(xml) do
    xml = String.replace(xml, ~r/(\sxmlns="\S+")|(xmlns:ns2="\S+")/, "")
    {:ok, tuples, _} = :erlsom.simple_form(xml)
    FastXmlToMap.parse(tuples)
  end

  def parse([value]) do
    case is_tuple(value) do
      true -> parse(value)
      false -> to_string(value) |> String.trim
    end
  end

  def parse({name, attr, content}) do
    parsed_content = parse(content)
    case is_map(parsed_content) do
      true -> 
        %{to_string(name) => parsed_content |> Map.merge(attr_map(attr))}
      false ->
        %{to_string(name) => parsed_content}
    end
  end

  def parse(list) when is_list(list) do
    parsed_list = Enum.map list, &({to_string(elem(&1,0)), parse(&1)}) 
    Enum.reduce parsed_list, %{}, fn {k,v}, acc -> 
      case Map.get(acc, k) do
        nil -> Map.put_new(acc, k, v[k])
        [h|t] -> Map.put(acc, k, [h|t] ++ [v[k]])
        prev -> Map.put(acc, k, [prev] ++ [v[k]])
      end
    end 
  end

  defp attr_map(list) do
    list |> Enum.map(fn {k,v} -> {to_string(k), to_string(v)} end) |> Map.new
  end

  ######################################################## 
  ########################################################

  def fxml_map(xml) do
    # data = String.replace(xml, ~r/(\sxmlns="\S+")|(xmlns:ns2="\S+")/, "")
    :fxml_stream.parse_element(xml) |> xml_to_map
  end

  def xml_to_map({:xmlcdata, cdata}) do
    cdata
  end
  def xml_to_map(xmlel(name: name, attrs: attrs, children: children)) do
    new_children = children |> Enum.filter(fn(ele) -> 
                        case ele do
                          {:xmlcdata, cdata} -> :string.trim(cdata) != "" 
                          _ -> true
                        end
                      end) 
    if attrs == [] do
      %{name => xml_to_map_by_list(new_children)}
    else  
      %{name => [fast_attr_map(attrs)] ++ xml_to_map_by_list(new_children)}
    end
  end

  def xml_to_map_by_list([]) do
    []
  end
  def xml_to_map_by_list(data) when is_list(data) do
    Enum.map(data, fn(ele) -> xml_to_map(ele) end)
  end

  defp fast_attr_map(list) do
    list |> Map.new
  end


  ######################################################## 
  ########################################################

  def naive_map_fxml(xml) do
    data = String.replace(xml, ~r/(\sxmlns="\S+")|(xmlns:ns2="\S+")/, "")
    :fxml_stream.parse_element(data)
    |> xml_to_tuple 
    |> tuple_xml_to_map
  end

  defp xml_to_tuple(pre_process) do
    xmlel(name: name, attrs: attrs, children: children) = pre_process
    new_children = children |> Enum.filter(fn(ele) -> 
                        case ele do
                          {:xmlcdata, cdata} -> :string.trim(cdata) != "" 
                          _ -> true
                        end
                      end) 
    case xml_to_tuple_by_list(new_children) do
      res when is_binary(res) -> {name, res}
      res when is_list(res) -> {name, attrs ++ res}
    end
  end

  defp xml_to_tuple_by_list([child]) do
    case child do
      {:xmlcdata, cdata} -> :string.trim(cdata)
      xmlel() -> [xml_to_tuple(child)]
    end
  end
  defp xml_to_tuple_by_list(children) when is_list(children) do
    children 
    |> Enum.map(fn(child) ->
        case child do
          {:xmlcdata, cdata} -> :string.trim(cdata)
          xmlel() -> xml_to_tuple(child)
        end
      end)
  end

  defp tuple_xml_to_map({k, v}) do
    %{k => xml_list_tuple_to_map(v)}
  end
  defp tuple_xml_to_map(an_bit) when is_binary(an_bit) do
    an_bit
  end
  defp tuple_xml_to_map(an_list) when is_list(an_list) do
    xml_list_tuple_to_map(an_list)
  end


  defp xml_list_tuple_to_map([]) do
    %{}
  end
  defp xml_list_tuple_to_map(data) when is_list(data) do
    data |> Enum.reduce(%{}, fn({k,v}, acc) ->
      new_v = tuple_xml_to_map(v)
      case Map.get(acc, k) do
        nil -> Map.put(acc, k, new_v)
        old when is_list(old) -> Map.put(acc, k,  old ++ [new_v]) 
        old -> Map.put(acc, k, [old, new_v])
      end
    end)
  end

end
