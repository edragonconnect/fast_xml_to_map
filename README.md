# FastXmlToMap

**Creates an Elixir Map data structure from an XML string**

Usage:

```elixir

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> FastXmlToMap.naive_map("<foo><bar>123</bar></foo>")
%{"foo" => %{"bar" => "123"}}
iex(2)> FastXmlToMap.naive_map_fxml("<foo><bar>123</bar></foo>")
%{"foo" => %{"bar" => "123"}}
iex(3)> FastXmlToMap.fxml_map("<foo><bar>123</bar></foo>")      
%{"foo" => [%{"bar" => ["123"]}]}
```

```elixir
Erlang/OTP 21 [erts-10.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> FastXmlToMap.naive_map("<foo><point><x>1</x><y>5</y></point><point><x>2</x><y>9</y></point></foo>")
%{"foo" => %{"point" => [%{"x" => "1", "y" => "5"}, %{"x" => "2", "y" => "9"}]}}
iex(2)> FastXmlToMap.naive_map_fxml("<foo><point><x>1</x><y>5</y></point><point><x>2</x><y>9</y></point></foo>")
%{"foo" => %{"point" => [%{"x" => "1", "y" => "5"}, %{"x" => "2", "y" => "9"}]}}
iex(3)> FastXmlToMap.fxml_map("<foo><point><x>1</x><y>5</y></point><point><x>2</x><y>9</y></point></foo>")      
%{
  "foo" => [
    %{"point" => [%{"x" => ["1"]}, %{"y" => ["5"]}]},
    %{"point" => [%{"x" => ["2"]}, %{"y" => ["9"]}]}
  ]
}
```

**FastXmlToMap.naive_map** api depends on **Erlsom** to parse xml then converts the return data into a map.
**FastXmlToMap.naive_map_fxml** and **FastXmlToMap.fxml_map** apis depends on **fast_xml** to pasrse xml then converts the return data into a map.


## Installation

Add `fast_xml_to_map` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:fast_xml_to_map, "~> 0.1.1"}]
end
```

Or install with github  
```elixir
def deps do
  [{:fast_xml_to_map, git: "https://github.com/edragonconnect/fast_xml_to_map.git", branch: "master"}]
end
```

## LICENSE  

[The MIT License (MIT)](./LICENSE)  
Copyright (c) 2019 [eDragonConnect Team](https://github.com/edragonconnect/)
  
## Benchmark
```
============================================================
=======================sim_data=============================
============================================================

Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.8.1
Erlang 21.3

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 2 s
parallel: 4
inputs: none specified
Estimated total run time: 27 s


Benchmarking fxml_map sim_data...
Benchmarking naive_map sim_data...
Benchmarking naive_map_fxml sim_data...

Name                              ips        average  deviation         median         99th %
naive_map sim_data               4.79      208.59 ms    ±14.48%      196.33 ms      325.92 ms
fxml_map sim_data                1.98      504.75 ms     ±3.29%      505.58 ms      543.33 ms
naive_map_fxml sim_data          1.41      710.04 ms     ±4.14%      711.31 ms      777.63 ms

Comparison: 
naive_map sim_data               4.79
fxml_map sim_data                1.98 - 2.42x slower
naive_map_fxml sim_data          1.41 - 3.40x slower

Memory usage statistics:

Name                            average  deviation         median         99th %
naive_map sim_data             67.71 MB     ±0.00%       67.71 MB       67.71 MB
fxml_map sim_data              69.92 MB     ±0.00%       69.92 MB       69.92 MB
naive_map_fxml sim_data        83.43 MB     ±0.00%       83.43 MB       83.43 MB

Comparison: 
naive_map sim_data             67.71 MB
fxml_map sim_data              69.92 MB - 1.03x memory usage
naive_map_fxml sim_data        83.43 MB - 1.23x memory usage

============================================================
======================ama_data==============================
============================================================

Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.8.1
Erlang 21.3

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 2 s
parallel: 4
inputs: none specified
Estimated total run time: 27 s


Benchmarking fxml_map ama_data...
Benchmarking naive_map ama_data...
Benchmarking naive_map_fxml ama_data...

Name                              ips        average  deviation         median         99th %
naive_map ama_data               0.34         2.95 s    ±10.81%         2.98 s         3.29 s
fxml_map ama_data                0.31         3.19 s     ±4.33%         3.18 s         3.33 s
naive_map_fxml ama_data         0.192         5.20 s     ±1.25%         5.22 s         5.25 s

Comparison: 
naive_map ama_data               0.34
fxml_map ama_data                0.31 - 1.08x slower
naive_map_fxml ama_data         0.192 - 1.76x slower

Memory usage statistics:

Name                            average  deviation         median         99th %
naive_map ama_data            466.45 MB     ±0.00%      466.45 MB      466.45 MB
fxml_map ama_data             334.13 MB     ±0.00%      334.13 MB      334.13 MB
naive_map_fxml ama_data       432.79 MB     ±0.00%      432.79 MB      432.79 MB

Comparison: 
naive_map ama_data            466.45 MB
fxml_map ama_data             334.13 MB - 0.72x memory usage
naive_map_fxml ama_data       432.79 MB - 0.93x memory usage

============================================================
====================long_ama_data===========================
============================================================

Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.8.1
Erlang 21.3

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 2 s
parallel: 4
inputs: none specified
Estimated total run time: 27 s


Benchmarking fxml_map long_ama_data...
Benchmarking naive_map long_ama_data...
Benchmarking naive_map_fxml long_ama_data...

Name                                   ips        average  deviation         median         99th %
naive_map long_ama_data              0.150         6.66 s     ±1.01%         6.67 s         6.74 s
fxml_map long_ama_data               0.121         8.25 s     ±0.86%         8.23 s         8.33 s
naive_map_fxml long_ama_data        0.0658        15.19 s     ±2.61%        15.29 s        15.54 s

Comparison: 
naive_map long_ama_data              0.150
fxml_map long_ama_data               0.121 - 1.24x slower
naive_map_fxml long_ama_data        0.0658 - 2.28x slower

Memory usage statistics:

Name                                 average  deviation         median         99th %
naive_map long_ama_data              1.26 GB     ±0.00%        1.26 GB        1.26 GB
fxml_map long_ama_data               0.91 GB     ±0.00%        0.91 GB        0.91 GB
naive_map_fxml long_ama_data         1.20 GB     ±0.00%        1.20 GB        1.20 GB

Comparison: 
naive_map long_ama_data              1.26 GB
fxml_map long_ama_data               0.91 GB - 0.72x memory usage
naive_map_fxml long_ama_data         1.20 GB - 0.95x memory usage

```