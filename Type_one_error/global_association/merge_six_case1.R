########### merge all simulations to calculate type 1 error
rm(list=ls())
setwd("/data/shengf2/simu_mtop/type1_global/result_six_case1/")


files <- list.files(pattern = "*.Rdata", full.names = TRUE)
# files <- list.files(path = ".", pattern = "*.Rdata", full.names = TRUE)
# Extract the key number from the file names
key_numbers <- as.numeric(gsub("[^[:digit:]]", "", files))



# Sort the files by the key numbers
files <- files[order(key_numbers)]
seeds = key_numbers[order(key_numbers)]
nfiles = length(files)



# initialize an empty data frame
alldata <- list()

# loop over all Rdata files and stack them vertically
for(i in 1:nfiles){
  # load the data from the file
  datai = load(files[i])
  dfi <- get(datai)
  
  # add the data to the all_data data frame
  alldata[[i]] = dfi
  # all_data <- rbind(all_data, dfi)
  
  if (i %%100==0){
    # Get current system time
    current_time <- Sys.time()
    current_time = as.character(current_time)
    cat("File",i,"with",ncol(dfi),"columns and",nrow(dfi),"rows is loaded at",
        current_time,"!!\n")
  }
}
all_data  <- do.call(rbind, alldata)
#42030000 simulations
nall = nrow(all_data)

pvalues = all_data

# save(pvalues,file = "../acat_six_case1.Rdata")

# colSums(p.acat<=1E-04)
# colSums(p.acat<=1E-05)
# colSums(p.acat<=1E-06)

## 3*3 matrix
colMeans(pvalues<=0.05)
nfiles

# a = 31; 53; 139; 168; 170; 172; 173; 176; 183; 187; 193; 194
# a = 169; 173; 187

# er2 = data.frame()
# for (a in 1:200){
# # for (a in 194){
#   set.seed(a)
#   id = sample(1:nall,3e7)
#   pvalues = all_data[id,]
#   
#   res1 = colMeans(pvalues<=1E-04,na.rm = T)
#   res2 = colMeans(pvalues<=1E-05,na.rm = T)
#   res3 = colMeans(pvalues<=1E-06,na.rm = T)
#   er2 = rbind(er2,res3)
#   cat(a,"-th simulation is done with type 1 error",res3[1],"!!\n")
#   if(res3[2] < 1.1e-6) break
# }


id1 = which(all_data[,2]<=1E-06)
p1 = all_data[id1,]
p2 = all_data[-id1,]
s1 = 32

er2 = data.frame()
# a = 17; 109; 117; 150; 158
# for(a in 33:200){
for(a in 17){
    
  set.seed(a)
  i1 = sample(1:nrow(p1),s1)
  i2 = sample(1:nrow(p2),3e7-s1)
  pvalues = rbind(p1[i1,], p2[i2,])
  
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


write.csv(res,paste0("../results",nall,"_six_case1_final.csv"), row.names =TRUE)
