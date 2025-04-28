########### merge all simulations to calculate type 1 error
rm(list=ls())
setwd("/data/shengf2/simu_mtop/time/result_six")


#p_acat

files = list.files(pattern = ".Rdata")
# library(gtools)
# files <- mixedsort(files)

## sorted by the created time
file_info <- file.info(files)
files <- files[order(file_info$ctime)]

nfiles = length(files)
print(nfiles)


# strsplit(files[1],"0.25_",".Rdata")
# str_extract(files[1], "(?<=0.25:)[0-9]*")



# num.sort <- as.numeric(gsub("[^\\d]+", "\\1", files, perl = TRUE))
# nop = as.numeric(gsub("[A-z \\.\\(\\)]","",files))
# library(stringr)
# # nop = as.numeric(str_extract(files, "(?<=0.25_:?)\\d+"))
# nop = as.numeric(str_extract(files, "(?<=:?)\\d+"))
# a1 = 1:100
# df1 = setdiff(a1,nop)
# df1

load(files[1])
# n1 = length(result[[1]])
n1 = 3

# result <- list(p_mglobal_result,p_standard,p_poly,p_topo)

#the result matrix contains 9 columns (2 scenarios* 3 sample*sizes)
#the column 1-3 represents scenario one (s==1), column 1-3 represents sample size 25000, 50000, 100000
#the column 4-6 represents scenario two (s==2), column 4-6 represents sample size 25000, 50000, 100000
#the column 7-9 represents scenario three (s==3), column 7-9 represents sample size 25000, 50000, 100000
#each row of the results matrix contains a simulation replicate
# nfiles = 1000
tm_mtop = matrix(0, nfiles, n1)
tm_topo = matrix(0, nfiles, n1)




for(i in 1:nfiles){
    load(files[i])
    tm_mtop[i,] = result[[1]][1:3,1]
    tm_topo[i,] = result[[2]][1:3,1]
    
    rm(result)
    
    if (i %%100==0){
      cat("File",i,"is loaded!!\n")
    }
}


save(tm_mtop,tm_topo, file = "../Six_time.Rdata")


## 4*9 matrix
mean_mtop = colMeans(tm_mtop)
med_mtop = apply(tm_mtop, 2, median)
mean_topo = colMeans(tm_topo)
med_topo = apply(tm_topo, 2, median)

nfiles

res = rbind(mean_mtop,med_mtop,mean_topo,med_topo)
row.names(res) = c("mean_mtop","med_mtop","mean_topo","med_topo")
res = res*100/3600
res
# write.csv(res,paste0("../results_six_test",nfiles,".csv"), row.names =TRUE)
