# using mtlab data to calaulate the Rt and its contour plot
# Pei Yuan
# 2020.06.20
library(R.matlab)
library(R0) 
library(EpiEstim)

## Serial interval ref
## Ali, S. T. et al (2020). Serial interval of SARS-CoV-2 was shortened over time 
##              by nonpharmaceutical interventions. Science, 369(6507), 1106-1109.

#set work path
#input date. data

Tor.date<-read.csv("Toronto_date_1102.csv", header=T)
Tor.date.name<-Tor.date$Date

# inpute matlab data
# With School open or close
I_new_2<-readMat("BC2_withSchoolOpen_ga.mat")
I_new_3<-readMat("BC2_withSchoolOpen_gc.mat")
#I_new_2<-readMat("BC2_withSchoolClose_ga.mat")
#I_new_3<-readMat("BC2_withSchoolClose_gc.mat")
R0_2.1_results<-vector()

# for adults
Num_for2<-length(I_new_2$new.infection)
for(i in 1:Num_for2) {
  I_new_try<-I_new_2$new.infection[[i]]
  I_new_2_case<-as.numeric(unlist(I_new_try))
  names(I_new_2_case)<-Tor.date.name
  
  Rt_est_2<- estimate_R(I_new_2_case, 
                       method = "uncertain_si",
                       config = make_config(list(
                         mean_si = 5.1, std_mean_si = 3.68,
                          min_mean_si = 2.6, max_mean_si = 7.8,
                          std_si = 5.3, std_std_si = 0.78,
                         min_std_si = 4.6, max_std_si = 5.3,
                         n1 = 500, n2 = 500)))
  R0_2.1_results[i]<-Rt_est_2$R$`Mean(R)`[60]
#  Rt_est_2<- estimate_R(I_new_2_case, 
#                        method = "parametric_si",
#                        config = make_config(list(
#                          mean_si = 7.5, std_si = 3.4)))
#  R0_2.1_results[i]<-Rt_est_2$R$`Mean(R)`[60]
}

R0_2.1<-matrix(R0_2.1_results,nrow = 9)
beta_2<-seq(from = 0.025, to = 0.065, by = 0.005)
C_2<-seq(from = 3, to = 10, by = 0.5)

library(plotly)
fig2.1 <- plot_ly(
  type = 'contour',
  x=C_2,
  y=beta_2,
  z=R0_2.1,
  colorscale = 'Jet',
  contours = list(
    coloring = 'heatmap',
    showlabels = TRUE
  )
)

# for C&Y
R0_3.1_results<-vector()
Num_for3<-length(I_new_3$new.infection)
for(i in 1:Num_for3) {
  I_new_try<-I_new_3$new.infection[[i]]
  I_new_3_case<-as.numeric(unlist(I_new_try))
  names(I_new_3_case)<-Tor.date.name
  Rt_est_3<- estimate_R(I_new_3_case, 
                      method = "uncertain_si",
                       config = make_config(list(
                         mean_si = 5.1, std_mean_si = 3.68,
                         min_mean_si = 2.6, max_mean_si = 7.8,
                         std_si = 5.3, std_std_si = 0.78,
                         min_std_si = 4.6, max_std_si = 5.3,
                         n1 = 500, n2 = 500)))
 R0_3.1_results[i]<-Rt_est_3$R$`Mean(R)`[60]
 # Rt_est_3<- estimate_R(I_new_3_case, 
 #                       method = "parametric_si",
 #                       config = make_config(list(
 #                         mean_si = 7.5, std_si = 3.4)))
#  R0_3.1_results[i]<-Rt_est_3$R$`Mean(R)`[60]
}

R0_3.1<-matrix(R0_3.1_results,nrow = 9)
beta_3<-seq(from = 0.025, to = 0.065, by = 0.005)
C_3<-seq(from = 3, to = 10, by = 0.5)

library(plotly)
fig3.1 <- plot_ly(
  type = 'contour',
  x=C_3,
  y=beta_3,
  z=R0_3.1,
  colorscale = 'Jet',
  contours = list(
    coloring = 'heatmap',
    showlabels = TRUE
  )
)
fig<-subplot(fig2.1,fig3.1)
fig
write.csv(R0_2.1,file="Rt_BC2_withSchoolOpen_ga.csv")
write.csv(R0_3.1,file="Rt_BC2_withSchoolOpen_gc.csv")
#write.csv(R0_2.1,file="Rt_BC2_withSchoolClose_ga.csv")
#write.csv(R0_3.1,file="Rt_BC2_withSchoolClose_gc.csv")
