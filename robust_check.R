setwd("/home/wigington/Dropbox (Weitz Group)/NatureMicro_noELATROUTSWAT/Code_and_Figures")
load("DATA.RData")
levels(data$Study)

studies<-c("BATS")
biased_obs<-which(data$Study %in% studies)
plot(data$VIRUS[-biased_obs] ~ data$BACTERIA[-biased_obs], log='xy')
points(data$VIRUS[biased_obs] ~ data$BACTERIA[biased_obs], pch=20,col='red')
data[biased_obs,"VIRUS"]<-data[biased_obs,"VIRUS"]*1.5
plot(data$VIRUS[-biased_obs] ~ data$BACTERIA[-biased_obs], log='xy')
points(data$VIRUS[biased_obs] ~ data$BACTERIA[biased_obs], pch=20,col='red')

shallow<-data[data$DEPTH<=100,]
shallow$DEPTH

studies<-c("BATS")
biased_obs<-which(shallow$Study %in% studies)
plot(shallow$VIRUS[-biased_obs] ~ shallow$BACTERIA[-biased_obs], log='xy')
points(shallow$VIRUS[biased_obs] ~ shallow$BACTERIA[biased_obs], pch=20,col='red')
shallow[biased_obs,"VIRUS"]<-shallow[biased_obs,"VIRUS"]*1.5
plot(shallow$VIRUS[-biased_obs] ~ shallow$BACTERIA[-biased_obs], log='xy')
points(shallow$VIRUS[biased_obs] ~ shallow$BACTERIA[biased_obs], pch=20,col='red')



pdf('20_percent_bias_across_studies.pdf', width=8, height=8)
plot(shallow$VIRUS ~ shallow$BACTERIA, log='xy', col='white', bty='n')
ints<-c()
slopes<-c()
rsqs<-c()
fracs<-c()
for (j in seq(3)){
  c<-data.frame(combn(levels(shallow$Study),j))
  for(i in seq(ncol(c))){
    studies <- as.vector(c[,i])
    biased_obs<-which(shallow$Study %in% studies)
    if(length(biased_obs)/nrow(shallow)<=.2){
      shallow[biased_obs,"VIRUS"]<-shallow[biased_obs,"VIRUS"]*1.5
      line<-lm(log10(shallow$VIRUS) ~ log10(shallow$BACTERIA))
      #abline(line)
      shallow[biased_obs,"VIRUS"]<-shallow[biased_obs,"VIRUS"]*(2/3)
      ints<-c(ints,summary(line)$coef[1])
      slopes<-c(slopes,summary(line)$coef[2])
      rsqs<-c(rsqs,summary(line)$r.squared)
      fracs<-c(fracs,length(biased_obs)/nrow(shallow))
    }
  }
}
dev.off()
hist(slopes, breaks=10)
hist(ints, breaks=10)
plot(shallow$VIRUS ~ shallow$BACTERIA, log='xy', col='white', bty='n')
for (i in seq(length(slopes))){
  abline(a=ints[i],b=slopes[i])
}
pdf("fraction_of_dataset_is_biased_50_percent_vs_rsquared.pdf", width=8, height=8)
plot(fracs,rsqs, bty='n')
dev.off()  
