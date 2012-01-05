
# from: http://al3xandr3.github.com/2011/02/05/weight-loss-predictor.html
al3x.hist = function(mydata, mycolname) {
  pl = ggplot(data = mydata)
  subvp = viewport(width=0.35, height=0.35, x=0.84, y=0.84)

  his = pl + 
        geom_histogram(aes_string(x=mycolname,y="..density.."),alpha=0.2) + 
        geom_density(aes_string(x=mycolname)) + 
        opts(title = names(mydata[mycolname]))

  qqp = pl + 
    geom_point(aes_string(sample=mycolname), stat="qq") +
      labs(x=NULL, y=NULL) + 
        opts(title = "QQ")
  
  print(his)
  print(qqp, vp = subvp)
}

al3x.hist2 = function (v1, v2, name1, name2) {
  freeg = data.frame(value = v1)
  paidg = data.frame(value = v2)
  freeg$metric = name1
  paidg$metric = name2
  df = rbind(freeg, paidg)
  # calculate the means
  cdf = summaryBy(data=df, value ~ metric, FUN=mean, na.rm=TRUE)

  # 2 hist  
  p1 = ggplot(df, aes_string(x="value", fill="metric")) + 
       geom_histogram(aes_string(y="..density..",fill="metric"), alpha=0.5) +  
       geom_vline(data=cdf, aes(xintercept=value.mean,colour=metric), linetype="dashed", size=0.4,alpha=0.6)
  
  # stripchart
  p2 = ggplot(df, aes_string(x="value", y="metric", color ="metric")) +
       geom_jitter(alpha=0.2) + 
      geom_vline(data=cdf, aes(xintercept=value.mean,  colour=metric), linetype="dashed", size=0.4, alpha=0.6)
  
  # grid display
  grid.arrange(p1, p2, nrow=2)
}

al3x.hist2.counts = function (v1, v2, name1, name2) {
  freeg = data.frame(value = v1)
  paidg = data.frame(value = v2)
  freeg$metric = name1
  paidg$metric = name2
  df = rbind(freeg, paidg)
  # calculate the means
  cdf = summaryBy(data=df, value ~ metric, FUN=mean, na.rm=TRUE)

  # 2 hist  
  p1 = ggplot(df, aes_string(x="value", fill="metric")) + geom_histogram(alpha=.5, position=position_identity(), aes_string(fill="metric")) + geom_line(aes_string(y="..count..", color="metric"),stat="density",size=0.4) + geom_vline(data=cdf, aes(xintercept=value.mean,  colour=metric), linetype="dashed", size=0.4,alpha=0.6)
  
  # stripchart
  p2 = ggplot(df, aes_string(x="value", y="metric", color ="metric")) +  geom_jitter(alpha=0.2) + geom_vline(data=cdf, aes(xintercept=value.mean,  colour=metric), linetype="dashed", size=0.4, alpha=0.6)
  
  # grid display
  grid.arrange(p1, p2, nrow=2)
}

# a = plot(c(1,2,3,4))
# a.png("~/Desktop/","plot.png",a)
al3x.png = function (flname, aplot, ...) {
  png(filename=flname, ...) 
  print(aplot)
  dev.off()
}

# df = data.frame(dt=c("2011-10-10","2011-10-11","2011-10-12"),kg=c(2,1,4),bmi=c(2,5,4))
# al3x.spark(df, "dt")
al3x.spark = function(df, pivot, date_range="1 days") {

  mp = melt(df, id=c(pivot))

  ggplot(mp, aes_string(x=pivot)) +
    geom_line(aes(y=value)) + 
    stat_smooth(aes(y=value),method="lm",se=FALSE,colour=alpha("blue",0.8),linetype=2, fullrange=TRUE) +
    facet_grid(variable ~ . , scales = "free") +
    opts(axis.text.x=theme_text(angle=-65,hjust=0), 
         panel.border=theme_rect(linetype = 0),
         strip.text.y = theme_text(size=15, angle = 0),
         panel.background = theme_rect(size = 1, colour = "lightgray"),
        strip.background = theme_blank()) +
    scale_x_date(name = "", major=date_range)
}
