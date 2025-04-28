########### merge all simulations to calculate type 1 error
rm(list=ls())
setwd("/data/NC_BW/HZ_SF/simulation_result")

# load("type_one_global_heter_size_2.rdata")
load("type_one_global_heter_size_3.rdata")


pvalues0 = result

# set.seed(2) for v2
set.seed(8) # for v3
i1 = sample(1:nrow(pvalues0),3e7)
pvalues = pvalues0[i1,]

res1 = colMeans(pvalues<=1E-04,na.rm = T)
res2 = colMeans(pvalues<=1E-05,na.rm = T)
res3 = colMeans(pvalues<=1E-06,na.rm = T)

res = rbind(res1,res2,res3)
row.names(res) = c("1E-04", "1E-05","1E-06")
colnames(res) = colnames(result)
res

setwd("/data/shengf2/simu_mtop/type1_hert/result_six")
# write.csv(res,paste0("./results2000_six_v3.csv"), row.names =TRUE)
