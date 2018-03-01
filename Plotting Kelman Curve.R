# Define Resolution
# 3840x2,160
# 1920x1,200
# 1280x720
input = readline("Run as Default? y/n  ")
if(input != "y"){
  wid = as.numeric(readline("Please input the width of the output: "))
  hei = as.numeric(readline("Please input the height of the output: "))
  pixelcount = c(wid,hei)
}else{
  pixelcount = c(1080,720)
}
print("Plotting in Progress...")

#Read the data from .txt file
if(file.exists("table.txt")){
  dat = read.table(file = "table.txt")
}else{
  dat = read.table(choose.files())
}

#Grouping the Data
pre = 2:7
post = 16:21
cms = c(pre,post)
con = 8:15

#Plotting CMS Samples
n = 1
for(i in cms){
  if(i < 10){
    filename = paste("CMSPR_", n, sep = "")
  }else if(i >= 10){
    filename = paste("CMSPO_", n - 6, sep = "")
  }
  jpeg(filename = paste(filename,".jpeg", sep = ""),
       width = pixelcount[1], height = pixelcount[2])
  plot(dat[,1],
       dat[,i],
       type = "b",
       pch = 16,
       cex = 1.5,
       xlab = "O2 Partial Pressure",
       ylab = "O2 Saturation",
       xlim = c(0,120),
       ylim = c(0,100),
       main = filename)
  dev.off()
  n = n + 1
}
rm(n, filename)

#Plotting Control Group Samples
n = 1
for(i in con){
  filename = paste("CON_", n, sep = "")
  jpeg(filename = paste(filename,".jpeg", sep = ""),
       width = pixelcount[1], height = pixelcount[2])
  plot(dat[,1],
       dat[,i],
       type = "b",
       pch = 16,
       cex = 1.5,
       xlab = "O2 Partial Pressure",
       ylab = "O2 Saturation",
       xlim = c(0,120),
       ylim = c(0,100),
       main = filename)
  dev.off()
  n = n + 1
}
rm(n, filename)

#Plotting CMS Samples Pre-Post Comparason
n = 1
for(i in pre){
  filename = paste("CMS_", n, sep = "")
  jpeg(filename = paste(filename,".jpeg", sep = ""),
       width = pixelcount[1], height = pixelcount[2])
  plot(dat[,1],
       dat[,i],
       type = "b",
       pch = 16,
       cex = 1.5,
       col = "red",
       xlab = "O2 Partial Pressure",
       ylab = "O2 Saturation",
       xlim = c(0,120),
       ylim = c(0,100),
       main = filename)
  par(new = TRUE)
  plot(dat[,1],
       dat[,i + 14],
       type = "b",
       pch = 16,
       cex = 1.5,
       col = "blue",
       xlab = "O2 Partial Pressure",
       ylab = "O2 Saturation",
       xlim = c(0,120),
       ylim = c(0,100),
       main = filename)
  dev.off()
  n = n + 1
}
cat("Pre CMS samples are marked red 
post CMS samples are marked blue.")

if(!dir.exists("Peru Samples")){
  dir.create(path = "Peru Samples")
}
pics = list.files(pattern = "jpeg")
file.copy(pics,"Peru Samples")
file.remove(pics)