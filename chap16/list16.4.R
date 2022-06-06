install.packages("ggplot2")     # グラフ描画に必要
install.packages("reshape2")    # データ整形に必要
install.packages("gridExtra")   # 複数グラフの描画に必要
install.packages("raster")      # 画像データの描画に必要

#ライブラリ呼び出し
library(ggplot2)
library(reshape2)
library(gridExtra)
library(raster)
#テストデータの読み込み
test<-read.table("test.csv",sep=",")
colnames(test)[1] <- "actual"   # 列名の変更
test$actual <- test$actual + 1  # "labelnames"の添え字が1始まりなので1足す

# 複数の図をコマ送りできるようにする
par(ask=T)

# ラベル名の読み込み
labelnames <- read.table("labelnames.csv",header=F,sep=",",stringsAsFactors=F)
labelnames <- labelnames[,1]

# 画像の描画
draw_img <- function(str_title,img,img_size){
        r <- g <- b <- raster(ncol=img_size,nrow=img_size)
        values(r) <- unlist(img[,1:(img_size*img_size)])
        values(g) <- unlist(img[,(img_size*img_size+1):(2*img_size*img_size)])
        values(b) <- unlist(img[,(2*img_size*img_size+1):ncol(img)])
        rgb <- stack(r,g,b)
        val <- getValues(rgb)
        xy <- as.data.frame(xyFromCell(rgb,1:ncell(rgb)))
        df <- cbind(xy,val)
        ggplot(df, aes(x=x, y=y,
                fill= rgb(layer.1,layer.2,layer.3, max=255))) +
        geom_raster() +
                theme(plot.title = element_text(size = rel(1.5)),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.ticks = element_blank(),
                axis.text = element_blank()) +
                        labs(title=str_title, x="", y="") + scale_fill_identity()
}

#10個のCIFAR-10の画像をランダム表示する
visualize_CIFAR10<-function(data,labels){
        act <- data$actual
        imgs <- data[,-1]

        #10個の乱数を発生
        rands <- as.integer(runif(10, min = 1, max = nrow(data)))
        for (i in 1:length(rands)){
                # ラベル用文字列の生成
                mainstr <- paste("actual:" , labels[act[rands[i]]])
                # グラフ表示
                print(draw_img(mainstr, imgs[rands[i],],32))
        }
}

#実行
visualize_CIFAR10(test, labelnames)
