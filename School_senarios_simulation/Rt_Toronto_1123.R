## compute the Rt of COVID-19 of Toronto incidence data 7.31-11.23
## using the R0  and EpiEstim package
## Pei Yuan 
## Date: 2021.04.26
library(EpiEstim)

## Serial interval ref
## Ali, S. T. et al (2020). Serial interval of SARS-CoV-2 was shortened over time 
##              by nonpharmaceutical interventions. Science, 369(6507), 1106-1109.

#set work path
#setwd("document_folder")
#input date. data
Tor.incidence <- read.csv("Toronto_0731_1123.csv", header=T)
TO.date.name<-Tor.incidence$Date
TO.data.a<-Tor.incidence$Iga
TO.data.c<-Tor.incidence$Igc
names(TO.data.a)<-TO.date.name
names(TO.data.c)<-TO.date.name

# using EpiEstim package calculate Rt
# serial interval: uncertain 
## For adults
TO.Rt.a<- estimate_R(TO.data.a, 
                    method = "uncertain_si",
                    config = make_config(list(
                      mean_si = 5.1, std_mean_si = 3.68,
                      min_mean_si = 2.6, max_mean_si = 7.8,
                      std_si = 5.3, std_std_si = 0.78,
                      min_std_si = 4.6, max_std_si = 5.3,
                      n1 = 500, n2 = 500)))
plot(TO.Rt.a)

TO.data_Rt.a<-TO.Rt.a$R

## For C&Y
TO.Rt.c<- estimate_R(TO.data.c, 
                     method = "uncertain_si",
                     config = make_config(list(
                       mean_si = 5.1, std_mean_si = 3.68,
                       min_mean_si = 2.6, max_mean_si = 7.8,
                       std_si = 5.3, std_std_si = 0.78,
                       min_std_si = 4.6, max_std_si = 5.3,
                       n1 = 500, n2 = 500)))
plot(TO.Rt.c)

TO.data_Rt.c<-TO.Rt.c$R


#plot(TO.data_Rt[146:250,3])

write.csv(TO.data_Rt.a,file="Toronto_Rt_a_1123.csv")
write.csv(TO.data_Rt.c,file="Toronto_Rt_c_1123.csv")