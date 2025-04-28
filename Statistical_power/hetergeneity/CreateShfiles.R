setwd("/data/shengf2/simu_mtop/power_hert/result_six/")
files  = list.files()
nums <- as.numeric(gsub("[^[:digit:]]", "", files))
s1  = setdiff(1:2000,nums)
length(s1)
# 814  818 2451 2452 2852 4451 4452 4851 4852 4853


setwd("/data/shengf2/simu_mtop/power_hert/")
# create a shell script file
fileName <- "job.sh"
fileConnection <- file(fileName, "w")

# add seeds to the shell script file using a for loop
n <- 2000
for (i in 1:n) {
  # cat(paste("Rscript /data/shengf2/simu_mtop/power_hert/3_stat_power_four_marker_heter.R", i, "\n"), 
  #     file = fileConnection, append = TRUE)
  cat(paste("Rscript /data/shengf2/simu_mtop/power_hert/4_stat_power_six_marker_heter.R", i, "\n"), 
      file = fileConnection, append = TRUE)
  
}

# close the file connection
close(fileConnection)

# make the shell script file executable
system(paste("chmod +x", fileName))


# swarm -f job.sh -p 2 -g 3  --module R --partition=quick   --time 4:00:00
# swarm -f job.sh -p 2  --module R --partition=quick   --time 4:00:00
# swarm -f job.sh -p 2 -g 2  --module R --time 48:00:00 
# swarm -f job.sh -p 2  --module R --partition=quick --time 2:00:00
# swarm -f job.sh -g 3  --module R --time 48:00:00
# swarm -f job.sh -g 3 --module R --partition=quick --time 4:00:00
# swarm -f job.sh -p 2 -g 5 --module R --partition=quick --time 4:00:00
# swarm -f job.sh -p 2 -g 5 --module R --time 240:00:00
# swarm -f job.sh -g 10 --module R --time 240:00:00

# swarm -f job.sh -p 2 -g 50 --module R --time 4:00:00
# swarm -f job.sh -g 100 --module R --time 240:00:00
# 58707441

# ls -tl | head -n 10
# ls -lt | head -n 6; ls -l | wc -l


