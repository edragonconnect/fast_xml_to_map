defmodule FastXmlToMap do
  require Record

  Record.defrecord :xmlel, Record.extract(:xmlel, from_lib: "fast_xml/include/fxml.hrl")

  def naive_map(data) do
    pre_process = :fxml_stream.parse_element(data)
    IO.inspect pre_process
    xml_to_tuple(pre_process) |> tuple_xml_to_map
  end

  defp xml_to_tuple(pre_process) do
    xmlel(name: name, children: children) = pre_process
    new_children = children |> Enum.filter(fn(ele) -> 
                        case ele do
                          {:xmlcdata, cdata} -> :string.trim(cdata) != "" 
                          _ -> true
                        end
                      end) 
    {name, xml_to_tuple_by_list(new_children)}
    # %{name => xml_to_tuple_by_list(new_children)}
  end

  defp xml_to_tuple_by_list([child]) do
    case child do
      {:xmlcdata, cdata} -> :string.trim(cdata)
      xmlel() -> xml_to_tuple(child)
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

  defp xml_list_tuple_to_map([]) do
    %{}
  end

  defp xml_list_tuple_to_map({k, v}) do
    %{k => v}
  end

  defp xml_list_tuple_to_map(data) when is_list(data) do
    data |> Enum.reduce(%{}, fn({k,v}, acc) ->
      new_v = xml_list_tuple_to_map(v)
      case Map.get(acc, k) do
        nil -> Map.put(acc, k, new_v)
        old when is_list(old) -> Map.put(acc, k, Enum.reverse([new_v| old])) 
        old -> Map.put(acc, k, [old, new_v])
      end
  end)
  end
end
