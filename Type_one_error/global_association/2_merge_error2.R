########### merge all simulations to calculate type 1 error
rm(list=ls())
# setwd("/data/shengf2/simu_mtop/type1/simulation/result1")
#p_global_result_mtop1
# 
setwd("/data/shengf2/simu_mtop/type1/simulation/result2")
#p_global_result_mtop1

# setwd("/data/shengf2/simu_mtop/type1/simulation/result3")
#p_global_result_mtop2


files = list.files(pattern = ".Rdata")
library(gtools)
files <- mixedsort(files)
nfiles = length(files)
print(nfiles)

# num.sort <- as.numeric(gsub("[^\\d]+", "\\1", files, perl = TRUE))
# nop = as.numeric(gsub("[A-z \\.\\(\\)]","",files))
# a1 = 1:3000
# df1 = setdiff(a1,nop)
# df1

load(files[1])
n1 = nrow(p_mtop1)
n2 = ncol(p_mtop1)

## information for three columns: size <- c(5000,50000,100000)
p.mtop1 <- matrix(0, n1*nfiles, n2)

for(i in 1:nfiles){
    a <- n1*(i-1)+1
    b <- n1*i
    vec <- a:b
    
    load(files[i])
    p.mtop1[vec,] = p_mtop1
    rm(p_mtop1)
    
    if (i %%100==0){
      cat("File",i,"is loaded!!\n")
    }
}

# colSums(p.mtop1<=5E-08)
# colMeans(p.mtop1<=5E-08)
# colSums(p.mtop1<=1E-04)

## 3*3 matrix
colMeans(p.mtop1<=0.05)
colMeans(p.mtop1<=1E-06)
