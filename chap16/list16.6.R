#予測結果とのマージ
merged <- cbind(prediction,test)

#予測成功/失敗データの抽出
success <- merged[merged$predicted==merged$actual,]
failure <- merged[merged$predicted!=merged$actual,]

# 複数の図をコマ送りできるようにする
par(ask=T)

#予測結果のbarplot作成
draw_barplot <- function(prob,labels){
        df <- melt(t(prob))
        ggplot(df, aes(x=Var1, y=value,fill=factor(Var1)))+
        geom_bar(stat="identity") +
        theme(axis.text = element_text(size = rel(1.2)),
              axis.ticks = element_blank(), legend.position="none",
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank()) +
        scale_x_discrete(labels=labels)+ coord_flip()+
        labs(title="",x = "", y = "") + scale_fill_grey(start = 0, end = .9)
}

#画像と予測結果の表示
visualize_predresult<-function(data,labels){
        pred <- data$predicted
        act <- data$actual
        probs <- data[,c(2:11)]
        imgs <- data[,-c(1:12)]

        # 10個の乱数を発生
        rands <- as.integer(runif(10, min = 1, max = nrow(data)))
        for (i in 1:10){
                # ラベル用文字列の生成
                rand <- rands[i]
                mainstr <- paste("actual:" , labels[act[rand]],
                                "\npredicted:", labels[pred[rand]])

                # 画像の描画
                p1 <- draw_img(mainstr, imgs[rand,],32)
                p2 <- draw_barplot(probs[rand,],labels)

                # グラフ表示
                grid.newpage()
                pushViewport(viewport(layout=grid.layout(1, 2) ))
                print(p1, vp=viewport(layout.pos.row=1, layout.pos.col=1))
                print(p2, vp=viewport(layout.pos.row=1, layout.pos.col=2))
        }
}

#成功例の描画
visualize_predresult(success,labelnames)
#失敗例の描画
visualize_predresult(failure,labelnames)
