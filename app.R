#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
setwd("C:/Users/lucad/OneDrive/Desktop/CODING FOR DATA SCIENCE/Mobile_Telecomunication_Market")
library(shiny)
library(readxl)
library(rdd)
library(rdrobust)
library(ggplot2)
source("functions_app.R")
Dataset_Telecomunication <- read_excel("Dataset_Telecomunication.xlsx")

#User Interface--------------------------------------------------------------------------------
ui <- navbarPage("The Iliad effect",

    tabPanel("Italian Mobile Telecomunication Tariffs",

    sidebarLayout(
        sidebarPanel(
            column(10,
                   helpText(div(h3("Dependent variable"), style="color:black"),div("Here you can choose the variable to be displayed in the scatterplot."), style="color:black"),
                   selectInput("select", label = h3(""),
                               choices = c("Daily giga", "Daily call minutes", "Daily sms", "Daily cost", "Aggregated quantity", "Giga per euro in tariff", "Call minutes per euro in tariff", "Sms per euro in tariff", "Euros per unit of aggregated quantity"), 
                               selected = "Daily giga"),
                   helpText(div(h3("Days from Iliad entry"), style="color:black"),div("The default range cover the entire dataset displaying mobile plans composition from September 2nd, 2015 to February 22nd, 2021 (exactly 1000 days before and after ",strong("Iliad entry"),").",br(),"You can however change the range and ",strong("zoom")," on determined period."), style="color:black"),
                   sliderInput("slider1", h3(""),
                               min = -1000, max = 1000, value = c(-1000,1000))),
                   helpText(div(h3("Operator"), style="color:black"),div("The operators selected by default are the so called ",strong("MNOs")," (those with their own network) while the others are ",strong("MVNOs")," (those without their own network).",br(),"You can choose to display observations of the operator that you want"), style="color:black"),
                   checkboxGroupInput("checkGroup", label = h3(""), 
                               choices = c("Vodafone","TIM","Wind","H3G","Wind Tre","Iliad","CoopVoce","Fastweb","Kena Mobile","PosteMobile", "Spusu", "Tiscali","UnoMobile","Very Mobile"), selected = c("Vodafone","TIM","Wind","H3G","Wind Tre","Iliad")),
        ),
        
        
        mainPanel(h3("Empirical analysis on price in Italian mobile telecommunication market:",br(), "the Iliad effect"),
                   h5("This is an interactive representation of the economic paper", em("'Empirical analysis on price in Italian
                   mobile telecommunication market: the Iliad effect'"), ". The paper aims to analyse the effect of the entry of Iliad in the Italian mobile
                   telecommunication market and it is available 'here' for further knowledge about the topic."),
            h5(strong("Dependent variable:")),h5(textOutput("depvar")),
            h5(strong("Scatterplot:")),
            plotOutput("distPlot"),
            h5(strong("Operator brief description:")),
            h5(textOutput("uno")),
            h5(textOutput("due")),
            h5(textOutput("tre"))
        )
    )),
    
    tabPanel("Sharp Regression Discontinuity",

    sidebarLayout(
        sidebarPanel(width=4,
            column(10,
                   helpText(div(h3("Dependent variable"), style="color:black"),div("Here you can choose the variable on which the ", strong("Sharp RD")," will be performed.",br(),em("'Euros per unit of aggregated quantity'")," is the most representative one."), style="color:black"),
                   selectInput("selectVar", label = h3(""), 
                               choices = c("Daily giga", "Daily call minutes", "Daily sms", "Daily cost", "Aggregated quantity", "Giga per euro in tariff", "Call minutes per euro in tariff", "Sms per euro in tariff", "Euros per unit of aggregated quantity"), 
                               selected = "Euros per unit of aggregated quantity"),
                   helpText(div(h3("Cutoff"), style="color:black"), br(), div("The default ",em("cutoff")," is set to ",strong("zero"), " which correspond exactly to May 29th 2018: when ", strong("Iliad")," entered the market. Changing the cutoff would mean to estimate the effect of a different event that took place near the selected day.",br(),"Note that the effect could always be slightly anticipated or posticipated.",style="color:black")),
                   sliderInput("sliderRDD", h3(""),
                               min = -500, max = 500, value = 0)),
                   selectInput("selectRDD", label = h3("Polinomial degree"), 
                               choices = c("1", "2", "3", "4"), 
                               selected = "1")
        ),
        
        mainPanel(width=8,h3("Econometric analysis"),h5(em("Regression discontinuity design"), " is a quasi experimental pretest/posttest design that supposedly elicits the causal effects 
                                                        of interventions by assigning a cutoff or threshold above or below which an intervention is assigned. By comparing observations lying 
                                                        closely on either side of the threshold, it is possible to estimate the average treatment effect. Sharp RD is used when treatment status 
                                                        is deterministic. In our case the treatment is the European Commission imposition to add a competitor in the Italian telecomunication market 
                                                        due to the precedent Wind and H3G fusion: the treatment took place on May 29th, 2018 when Iliad entered the market."),
                  h5(strong("Dependent variable:")),h5(textOutput("depvar2")),h5(strong("RD Plot:")),plotOutput("RDD"), textOutput("coeff")
        )
    ))
    
)

#Server----------------------------------------------------------------------------------------
server <- function(input, output) {
    output$depvar <- renderText({
        Dependentvar <- var_descri(input$select)
        paste(Dependentvar)
    
    })

    output$distPlot <- renderPlot({
        z    <-subset(Dataset_Telecomunication, (Dataset_Telecomunication$time_from_iliad_entry>input$slider1[1] & Dataset_Telecomunication$time_from_iliad_entry<input$slider1[2]) & Dataset_Telecomunication$mobile_network_operator %in% input$checkGroup)
        dependent_variable <- switch (input$select,
                             "Daily giga" = z$daily_giga,
                             "Daily call minutes" = z$daily_calls_mins,
                             "Daily sms" = z$daily_sms,
                             "Daily cost" = z$daily_cost ,
                             "Aggregated quantity" = z$aggregated_index,
                             "Giga per euro in tariff" = z$daily_giga_cost,
                             "Call minutes per euro in tariff" = z$daily_calls_mins_cost,
                             "Sms per euro in tariff" = z$daily_sms_cost,
                             "Euros per unit of aggregated quantity" = z$aggregated_index_cost
                             )
    
        
        ggplot(z) + geom_point(aes(x=time_from_iliad_entry, 
                                   y=dependent_variable, size=daily_cost, color=mobile_network_operator)) + labs(title="", x="Days from Iliad entry", y=input$select) + theme(plot.title=element_text(size=30,face="bold",color="orange",hjust=0.5),
                                                                                                               axis.text.x=element_text(size=15,color="blue"),
                                                                                                               axis.text.y=element_text(size=15,color="blue"),
                                                                                                               axis.title.x=element_text(size=20),
                                                                                                               axis.title.y=element_text(size=20))
        
    })
    
    output$uno <- renderText({
        cheallafiera<-unoduetre()
        if (length(cheallafiera)>0){
            cheallafiera[1]
        }
        else {""}
    })
    output$due <- renderText({
        cheallafiera<-unoduetre()
        if (length(cheallafiera)>1){
            cheallafiera[2]
        }
        else {""}
    })
    output$tre <- renderText({"hola"})
    unoduetre<-reactive({
        descriptionset<-list()
        for(i in 1:length(input$checkGroup)){
            descriptionset[length(descriptionset)+1]<-operdescri(input$checkGroup[i])
        }
        return(paste(descriptionset,sep="") )
    })
    
    output$depvar2 <- renderText({
        Dependentvar2 <- var_descri(input$selectVar)
        paste(Dependentvar2)
        
    })
    
    output$RDD <- renderPlot({
        dependent_variable2 <- switch (input$selectVar,
                                      "Daily giga" = Dataset_Telecomunication$daily_giga,
                                      "Daily call minutes" = Dataset_Telecomunication$daily_calls_mins,
                                      "Daily sms" = Dataset_Telecomunication$daily_sms,
                                      "Daily cost" = Dataset_Telecomunication$daily_cost ,
                                      "Aggregated quantity" = Dataset_Telecomunication$aggregated_index,
                                      "Giga per euro in tariff" = Dataset_Telecomunication$daily_giga_cost,
                                      "Call minutes per euro in tariff" = Dataset_Telecomunication$daily_calls_mins_cost,
                                      "Sms per euro in tariff" = Dataset_Telecomunication$daily_sms_cost,
                                      "Euros per unit of aggregated quantity" = Dataset_Telecomunication$aggregated_index_cost)
        
        rdplot(y=dependent_variable2, Dataset_Telecomunication$time_from_iliad_entry, c = input$sliderRDD, 
               p = as.numeric(input$selectRDD),title="",col.dots = "red",col.lines = "blue", x.label= "Days from Iliad entry",
               y.label=input$selectVar)
        
    })
    output$coeff <- renderText({
        dependent_variable2 <- switch (input$selectVar,
                                       "Daily giga" = Dataset_Telecomunication$daily_giga,
                                       "Daily call minutes" = Dataset_Telecomunication$daily_calls_mins,
                                       "Daily sms" = Dataset_Telecomunication$daily_sms,
                                       "Daily cost" = Dataset_Telecomunication$daily_cost ,
                                       "Aggregated quantity" = Dataset_Telecomunication$aggregated_index,
                                       "Giga per euro in tariff" = Dataset_Telecomunication$daily_giga_cost,
                                       "Call minutes per euro in tariff" = Dataset_Telecomunication$daily_calls_mins_cost,
                                       "Sms per euro in tariff" = Dataset_Telecomunication$daily_sms_cost,
                                       "Euros per unit of aggregated quantity" = Dataset_Telecomunication$aggregated_index_cost)
        k<-rdrobust(y=dependent_variable2, Dataset_Telecomunication$time_from_iliad_entry, c = input$sliderRDD, fuzzy = NULL, p = as.numeric(input$selectRDD))
        c<-k$Estimate[1]
        pv<-k$pv[1]
        options(scipen=999)
        l<-paste("The estimated coefficient of interest takes value ", round(c,digits=3), "and pvalue", round(pv,digits=3))
        if(pv>=0.00500000){paste(l, ". The effect of what happened in day ",input$sliderRDD, " before Iliad entered the market is statistically NOT significant")
            
        } else{paste(l,". The effect of what happened ",input$sliderRDD, " days from Iliad entry on the dependent variable is statistically significant")
            
        }
    })
}

# Run the application------------------------------------------------------------------------
shinyApp(ui = ui, server = server)
