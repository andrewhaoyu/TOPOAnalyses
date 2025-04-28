########### merge all simulations to calculate type 1 error
rm(list=ls())
# setwd("/data/shengf2/simu_mtop/type1_global/result_six_case12/result")
setwd("/data/shengf2/simu_mtop/type1_global/result_six_case12/result2")


files <- list.files(pattern = "*.Rdata", full.names = TRUE)
# files <- list.files(path = ".", pattern = "*.Rdata", full.names = TRUE)
# Extract the key number from the file names
key_numbers <- as.numeric(gsub("[^[:digit:]]", "", files))



# Sort the files by the key numbers
files <- files[order(key_numbers)]
seeds = key_numbers[order(key_numbers)]
nfiles = length(files)



# initialize an empty data frame
all_data <- data.frame()

# loop over all Rdata files and stack them vertically
for(i in 1:nfiles){
  # load the data from the file
  datai = load(files[i])
  dfi <- get(datai)
  
  # add the data to the all_data data frame
  all_data <- rbind(all_data, dfi)
  
  if (i %%100==0){
    # Get current system time
    current_time <- Sys.time()
    current_time = as.character(current_time)
    cat("File",i,"with",ncol(dfi),"columns and",nrow(dfi),"rows is loaded at",
        current_time,"!!\n")
  }
}


colnames(all_data)<- c(5000,50000)
#36787500 simulations
nall = nrow(all_data)

pvalues = all_data

save(pvalues, file = "../mtop1.Rdata")

# colSums(p.acat<=1E-04)
# colSums(p.acat<=1E-05)
# colSums(p.acat<=1E-06)

## 3*3 matrix
colMeans(pvalues<=0.05)
nfiles


res1 = colMeans(pvalues<=1E-04,na.rm = T)
res2 = colMeans(pvalues<=1E-05,na.rm = T)
res3 = colMeans(pvalues<=1E-06,na.rm = T)

res = rbind(res1,res2,res3)
row.names(res) = c("1E-04", "1E-05","1E-06")
res
# write.csv(res,paste0("../results",nall,"_six_c12_acat.csv"), row.names =TRUE)
# write.csv(res,paste0("../results",nall,"_six_c12_ftop.csv"), row.names =TRUE)
write.csv(res,paste0("../results",nall,"_six_c12_mtop1.csv"), row.names =TRUE)
# write.csv(res,paste0("../results",nall,"_six_c12_mtop2.csv"), row.names =TRUE)
