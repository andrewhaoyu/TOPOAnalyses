########### merge all simulations to calculate type 1 error
rm(list=ls())
setwd("/data/shengf2/simu_mtop/type1_global/result_six_case12/")
files <- list.files(pattern = "*.Rdata", full.names = TRUE)

# load("acat.Rdata")
# load("ftop.Rdata")
# load("mtop1.Rdata")
load("mtop2.Rdata")

#36787500 simulations
all_data = pvalues
nall = nrow(all_data)
nall

## 3*3 matrix
colMeans(all_data<=0.05)

# a = 25;115;120;190
set.seed(25)
id = sample(1:nall,3e7)
pvalues = all_data[id,]

res1 = colMeans(pvalues<=1E-04,na.rm = T)
res2 = colMeans(pvalues<=1E-05,na.rm = T)
res3 = colMeans(pvalues<=1E-06,na.rm = T)

res = rbind(res1,res2,res3)
row.names(res) = c("1E-04", "1E-05","1E-06")
res


# write.csv(res,paste0("results",nall,"_six_c12_acat.csv"), row.names =TRUE)
# write.csv(res,paste0("./results",nall,"_six_c12_ftop.csv"), row.names =TRUE)
# write.csv(res,paste0("./results",nall,"_six_c12_mtop1.csv"), row.names =TRUE)
write.csv(res,paste0("./results",nall,"_six_c12_mtop2.csv"), row.names =TRUE)
