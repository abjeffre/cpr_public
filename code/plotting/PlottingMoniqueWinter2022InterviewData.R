library(tidyverse)
df<-read_csv("cpr_public/data/MoniqueSummer2022InterviewData.csv")
View(df)

mytheme<-theme(axis.title = element_text(colour = "black",size=18),
               axis.text = element_text(colour = "black",size=14),
               legend.text = element_text(color="black",size=12))

ylabel<-expression(paste("Proportion of ", italic("shehia")))


df %>%
  mutate(ext_theft_mentioned=ifelse(ext_theft_mentioned==1,"Yes","No"),
         active_catch_ab_7=ifelse(active_catch_ab_7==1,"Yes","No"),
         active_report_out_vo=ifelse(active_report_out_vo==1,"Yes","No"),
         active_patrols_per_month_dichto=ifelse(active_patrols_per_month_dichto==1,"Yes","No"),
         active_bound_mark=ifelse(active_bound_mark==1,"Yes","No"))%>%
  select(ext_theft_mentioned,active_catch_ab_7,active_report_out_vo,active_patrols_per_month_dichto,active_bound_mark)%>%
  pivot_longer(cols=c(active_catch_ab_7:active_bound_mark),names_to = "Activity",values_to="Doing")%>%
  filter(Doing=="Yes")%>%
  group_by(ext_theft_mentioned,Activity) %>%
  summarise( 
    n=n())%>%
  mutate(tot=ifelse(ext_theft_mentioned=="Yes",nrow(df[df$ext_theft_mentioned==1,]),
                    nrow(df[df$ext_theft_mentioned==0,]) ))%>%
  ungroup()%>%group_by(Activity,ext_theft_mentioned)%>%
  mutate(prop=n/tot,
         se=(prop*(1-prop))/28,
         #ic=se * qt((1-0.05)/2 + .5, sum(n)-1))%>%
         ci=sqrt(se)*1.96)%>%
  mutate(Activity=as.factor(Activity))%>%
ggplot(.,aes(x=ext_theft_mentioned,y=prop,by=Activity)) +
  geom_bar( aes(fill=Activity), stat="identity",position=position_dodge(width=0.9), alpha=1,size=0.5,color="#636363") +
  geom_linerange( aes( ymin=prop-ci, ymax=prop+ci), alpha=1, size=0.75,position=position_dodge(.9))+
  #geom_text(aes(label=n),color="white",fontface="bold",position=position_dodge(.9),vjust =2.5)+
  geom_text(aes(label=n),color="black",fontface="bold",position=position_dodge(.9),vjust =-8.5)+
  geom_text(x=1.6, y=0.838, label="n =",fontface="bold" )+
  ylim(-0.01,1.0)+
  #geom_text(aes(label=n),color="white",fontface="bold",position=position_fill(0.5))+
  scale_fill_manual(values=c(active_bound_mark="#a6cee3",
                             active_catch_ab_7="#33a02c",
                             active_patrols_per_month_dichto="#b2df8a",
                    active_report_out_vo="#1f78b4"),
                    labels=c("Boundary marking",
                             "Arrests (>7 in past year)",
                             "Patrols (>7 in past year)",
                             "Report to outside authorities"))+
  xlab("Resource theft emphasized")+ylab(ylabel)+
  theme_classic()+
  mytheme


###


df %>%
  mutate(ext_theft_mentioned=ifelse(ext_theft_mentioned==1,"Yes","No"),
         active_meetings=ifelse(active_meetings==1,"Yes","No"),
         active_plant=ifelse(active_plant==1,"Yes","No"))%>%
  select(ext_theft_mentioned,active_plant,active_meetings)%>%
  pivot_longer(cols=c(active_plant:active_meetings),names_to = "Activity",values_to="Doing")%>%
  filter(Doing=="Yes")%>%
  group_by(ext_theft_mentioned,Activity) %>%
  summarise( 
    n=n())%>%
  mutate(tot=ifelse(ext_theft_mentioned=="Yes",nrow(df[df$ext_theft_mentioned==1,]),
                    nrow(df[df$ext_theft_mentioned==0,]) ))%>%
  ungroup()%>%group_by(Activity,ext_theft_mentioned)%>%
  mutate(prop=n/tot,
         se=(prop*(1-prop))/28,
         #ic=se * qt((1-0.05)/2 + .5, sum(n)-1))%>%
         ci=sqrt(se)*1.96)%>%
  mutate(Activity=as.factor(Activity))%>%
  ggplot(.,aes(x=ext_theft_mentioned,y=prop,by=Activity)) +
  geom_bar( aes(fill=Activity), stat="identity",position=position_dodge(width=0.9), alpha=1,size=0.5,color="#636363") +
  geom_linerange( aes( ymin=prop-ci, ymax=prop+ci), alpha=1, size=0.75,position=position_dodge(.9))+
  #geom_text(aes(label=n),color="white",fontface="bold",position=position_dodge(.9),vjust =4)+
  geom_text(aes(label=n),color="black",fontface="bold",position=position_dodge(.9),vjust =12)+
  geom_text(x=1.71, y=0.425, label="n =",fontface="bold" )+
  scale_fill_manual(values=c(active_meetings="#8da0cb",
                             active_plant="#66c2a5"),
                    labels=c("Regularly held meetings",
                             "Regular planting schedule"))+
  xlab("Resource theft emphasized")+ylab(ylabel)+
  theme_classic()+
  mytheme
