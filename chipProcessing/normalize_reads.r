setwd("/mnt/silencer2/home/yanxiazh/projects/cardiac_dev/data/chipseq/counts")

a=data.frame(fread("H3K27me3.counts",skip=1))
b=read.table("../merged_peaks/H3K27me3_merged_peaks.over_input.bed")
counts = a[,-c(1:6)]
rpm = sweep(counts,2,colSums(counts),'/')*1e6
rpkm = sweep(rpm,1,a$Length,'/')*1e3
rpkm.out = cbind(a[,1:6],rpkm)

rpkm.input = rpkm[which(a$Geneid %in% b$V4),]
rpkm.noninput = rpkm[which(!a$Geneid %in% b$V4),]

plot(rpkm[,1],rpkm[,2])
abline(0,1)
points(rpkm.input[,1],rpkm.input[,2],col='red')

write.table(rpkm.out, "H3K27me3.rpkm",row.names=F,sep='\t',quote=F)

