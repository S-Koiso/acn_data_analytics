# my_prediction.csv�̓ǂݍ���
prediction <- read.table("my_prediction.csv", header = T, sep=",")
colnames(prediction)[1] <- "predicted"  #�񖼂̕ύX
prediction$predicted <- prediction$predicted + 1
# "labelnames"�̓Y������1�n�܂�Ȃ̂�1����
# �擪6�s�̕\��
head(prediction)