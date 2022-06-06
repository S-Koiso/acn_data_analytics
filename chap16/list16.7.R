# 混同行列テーブルの作成
confmat <- table(labelnames[merged$actual+1],labelnames[merged$predicted+1])
df <- melt(t(confmat))
colnames(df)[1] <- "predicted"  # 列名の変更
colnames(df)[2] <- "actual"     # 列名の変更
colnames(df)[3] <- "count"      # 列名の変更

#グラフ作成
p <- ggplot(df, aes(predicted, count, fill=predicted)) +
                geom_bar(stat="identity") +
                theme(axis.ticks = element_blank(),
                axis.text.x = element_blank(),
                strip.text.x = element_text(size = rel(1.2)),
                legend.text=element_text(size=rel(1.2)),
                 panel.grid.major = element_blank(),
                 panel.grid.minor = element_blank(),
                 panel.background = element_blank()
)

# グラフ描画の実行
p + facet_wrap(~actual) + scale_fill_grey(start = 0, end = .9)
