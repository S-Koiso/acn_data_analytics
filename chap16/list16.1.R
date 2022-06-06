# 作業ディレクトリへの移動
setwd("path") # path=先ほど作成した作業用ディレクトリへのパス

# パッケージH2Oのインストール
install.packages("h2o")

# 現在起動しているRセッションにパッケージH2Oを読み込む
library(h2o)

# H2Oを起動する
# nthreadsでスレッド数を指定（-1はすべてのCPUコアを使用することを意味する）
# max_mem_sizeで使用可能な最大メモリ数を指定（ここでは2GB）
localH2O = h2o.init(nthreads = -1, max_mem_size="2g")
