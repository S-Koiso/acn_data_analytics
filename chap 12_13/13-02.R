# osmarパッケージの導入
install.packages("osmar")
library(osmar)

# 地図データのインポート
cb <- center_bbox(139.7079, 35.6671, 500, 500)
map <- get_osm(cb, source=osmsource_api())

# 地図情報のプロット
plot_nodes(map, col="blue", pch='.', xlim=c(139.7042, 139.7118), ylim=c(35.665, 35.669))
plot_ways(map, add=TRUE, col="green")

# igraph パッケージの導入
install.packages("igraph")
library(igraph)

# 地図データの変換、グラフデータの確認
graph <- as.undirected(as_igraph(map))

# 1番目に格納されているノードのノードIDを確認
V(graph)$name[1]

# インデックス番号1のノードに接続されたリンク情報を確認
E(graph)[1]

# このリンクのリンクIDを確認
E(graph)$name[1]

# このリンクの長さを確認
E(graph)$weight[1]

# ダイクストラ法による最短経路の探索
path <- get.shortest.paths(graph, which(V(graph)$name==517470381), which(V(graph)$name==158030002))

# 結果を確認
path$vpath[[1]]$name

# ノードのインデックス番号からOpenStreetMapのノードIDへ変換
nodes <- V(graph)$name[path$vpath[[1]]]
nodes <- unlist(lapply(nodes, as.numeric))

# ノード配列が対応するOpenStreetMapオブジェクトを作成して地図上へプロット
path_ids <- list()
path_ids$node_ids <- nodes
path_map <- subset(map, ids=path_ids)
plot_nodes(path_map, add=TRUE, col="blue", pch=20)
