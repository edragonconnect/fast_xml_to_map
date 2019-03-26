count = Enum.to_list(1..1000)

sim_data = XmlData.sample_xml()
ama_data = XmlData.amazon_xml()
long_ama_data = XmlData.long_amazon_xml()

# Benchee.run(
#   %{
#     "naive_map sim_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map(sim_data) end) end,
#     "naive_map_fxml sim_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map_fxml(sim_data) end) end,
#     "fxml_map sim_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.fxml_map(sim_data) end) end
#   },
#   time: 5,
#   memory_time: 2,
#   parallel: 4
# )

# Benchee.run(
#   %{
#     "naive_map ama_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map(ama_data) end) end,
#     "naive_map_fxml ama_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map_fxml(ama_data) end) end,
#     "fxml_map ama_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.fxml_map(ama_data) end) end
#   },
#   time: 5,
#   memory_time: 2,
#   parallel: 4
# )

Benchee.run(
  %{
    "naive_map long_ama_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map(long_ama_data) end) end,
    "naive_map_fxml long_ama_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.naive_map_fxml(long_ama_data) end) end,
    "fxml_map long_ama_data" => fn -> Enum.each(count, fn(_) -> FastXmlToMap.fxml_map(long_ama_data) end) end
  },
  time: 5,
  memory_time: 2,
  parallel: 4
)
