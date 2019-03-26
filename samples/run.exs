count = Enum.to_list(1..1000)

target_data = XmlData.expectation()
xml_data = XmlData.sample_xml()

Benchee.run(
  %{
    "elixir_xml" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map(xml_data) == target_data end) end,
    "fast_xml" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.fast_naive_map(xml_data) == target_data end) end
  },
  time: 5,
  memory_time: 2,
  parallel: 4
)
