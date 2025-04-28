########### merge all simulations to calculate type 1 error
rm(list=ls())
setwd("/data/shengf2/simu_mtop/type1/simulation/nresult")
# setwd("/data/shengf2/simu_mtop/type1error/simulation/result")

#p_acat

files = list.files(pattern = "acat.*\\.Rdata")
library(gtools)
files <- mixedsort(files)
nfiles = length(files)
print(nfiles)

# num.sort <- as.numeric(gsub("[^\\d]+", "\\1", files, perl = TRUE))
# nop = as.numeric(gsub("[A-z \\.\\(\\)]","",files))
# a1 = 3001:4000
# df1 = setdiff(a1,nop)
# df1

load(files[1])
n1 = nrow(p_acat)
n2 = ncol(p_acat)

## information for three columns: size <- c(5000,50000,100000)
p.acat <- matrix(0, n1*nfiles, n2)

for(i in 1:nfiles){
    a <- n1*(i-1)+1
    b <- n1*i
    vec <- a:b
    
    load(files[i])
    p.acat[vec,] = p_acat
    rm(p_acat)
    
    if (i %%100==0){
      cat("File",i,"is loaded!!\n")
    }
}

# colSums(p.acat<=5E-08)
# colMeans(p.acat<=5E-08)
# colSums(p.acat<=1E-04)
# colSums(p.acat<=1E-05)
# colSums(p.acat<=1E-06)

## 3*3 matrix
mean(p.acat<=1E-04)
mean(p.acat<=1E-05)
mean(p.acat<=1E-06)
mean(p.acat<=0.05)
nfiles
