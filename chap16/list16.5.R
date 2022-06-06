# my_prediction.csvの読み込み
prediction <- read.table("my_prediction.csv", header = T, sep=",")
colnames(prediction)[1] <- "predicted"  #列名の変更
prediction$predicted <- prediction$predicted + 1
# "labelnames"の添え字が1始まりなので1足す
# 先頭6行の表示
head(prediction)
