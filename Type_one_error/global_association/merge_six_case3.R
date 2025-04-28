########### merge all simulations to calculate type 1 error
rm(list=ls())
setwd("/data/shengf2/simu_mtop/type1_global/")
load("type_one_global_assoc_size_3.rdata")

all_data = result
nall = nrow(result)

# a = 3
for (a in 1:200){
  set.seed(a)
  id = sample(1:nall,3e7)
  pvalues = all_data[id,]
  # pvalues = all_data
  res1 = colMeans(pvalues<=1E-04,na.rm = T)
  res2 = colMeans(pvalues<=1E-05,na.rm = T)
  res3 = colMeans(pvalues<=1E-06,na.rm = T)
  
  cat(a,"-th simulation is done with type 1 error",res3[4],"!!\n")
  if(res3[4]>0.9e-6) break
}


res = rbind(res1,res2,res3)
row.names(res) = c("1E-04", "1E-05","1E-06")
res

write.csv(res,paste0("./results",nall,"_six_case3.csv"), row.names =TRUE)


