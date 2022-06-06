# 作業ディレクトリへの移動
#（前のコマンドから続けて入力している場合不要）
setwd("path")   # path=先ほど作成した作業用ディレクトリへのパス

# パッケージH2Oのインストール
#（H2Oがすでに起動している場合不要）
library(h2o)
localH2O = h2o.init(nthreads = -1, max_mem_size="2g")

# トレーニング用データセットの読み込み
path_train_data <- "./train.csv"
CIFAR10_train <- h2o.importFile(localH2O, path = path_train_data, key="CIFAR10_train")

# ディープラーニングによるモデル構築
my_deeplearning<-h2o.deeplearning(x=seq(2,ncol(CIFAR10_train)), y=1,
                                  data=CIFAR10_train, classification=T,
                                  hidden=c(200,200,200), activation="Tanh",
                                  ignore_const_cols=T)

# テスト用データセットの読み込み
path_test_data = "./test.csv"
CIFAR10_test <- h2o.importFile(localH2O, path = path_test_data, key="CIFAR10_test")

# 作成したモデルを用いた予測の実行
my_prediction <- h2o.predict(object = my_deeplearning, newdata = CIFAR10_test)

# 混同行列の作成
h2o.confusionMatrix(my_prediction[,1],CIFAR10_test[,1])
