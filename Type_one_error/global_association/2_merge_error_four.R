########### merge all simulations to calculate type 1 error
rm(list=ls())
# setwd("/data/shengf2/simu_mtop/type1_global/result_four1/result")
# setwd("/data/shengf2/simu_mtop/type1_global/result_four1/result1")
# setwd("/data/shengf2/simu_mtop/type1_global/result_four1/result2")
setwd("/data/shengf2/simu_mtop/type1_global/result_four1/result3")


files <- list.files(pattern = "*.Rdata", full.names = TRUE)
# files <- list.files(path = ".", pattern = "*.Rdata", full.names = TRUE)
# Extract the key number from the file names
key_numbers <- as.numeric(gsub("[^[:digit:]]", "", files))



# Sort the files by the key numbers
files <- files[order(key_numbers)]
seeds = key_numbers[order(key_numbers)]
nfiles = length(files)


data = load(files[1])
df <- data.frame(get(data))
n1 = nrow(df)
n2 = ncol(df)


## information for three columns: size <- c(5000,50000,100000)
pvalues <- matrix(NA, n1*nfiles, n2)
colnames(pvalues)<- c(5000,50000,100000)


for(i in 1:nfiles){
    a <- n1*(i-1)+1
    b <- n1*i
    vec <- a:b
    
    datai = load(files[i])
    dfi <- get(datai)
    pvalues[vec,] = dfi
    rm(dfi)
    
    if (i %%100==0){
      cat("File",i,"is loaded!!\n")
    }
}

# colSums(p.acat<=1E-04)
# colSums(p.acat<=1E-05)
# colSums(p.acat<=1E-06)

## 3*3 matrix
colMeans(pvalues<=0.05)
nfiles

pvalues0 = pvalues
er2 = data.frame()
# a = 40
# for(a in 1:200){
for(a in 40){

  set.seed(a)
  i2 = sample(1:nrow(pvalues0),3e7)
  pvalues = pvalues0[i2,]
  
  res1 = colMeans(pvalues<=1E-04,na.rm = T)
  res2 = colMeans(pvalues<=1E-05,na.rm = T)
  res3 = colMeans(pvalues<=1E-06,na.rm = T)
  er2 = rbind(er2,res3)
  cat(a,"-th simulation is done with type 1 error",res3,"!!\n")
  if(all(res3 < 1.05e-6)) break
}
res = rbind(res1,res2,res3)
row.names(res) = c("1E-04", "1E-05","1E-06")
res
# write.csv(res,paste0("../results",nfiles,"_four_acat.csv"), row.names =TRUE)
# write.csv(res,paste0("../results",nfiles,"_four_ftop.csv"), row.names =TRUE)
# write.csv(res,paste0("../results",nfiles,"_four_mtop1.csv"), row.names =TRUE)
write.csv(res,paste0("../results",nfiles,"_four_mtop2.csv"), row.names =TRUE)
