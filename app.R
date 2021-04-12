#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#setwd("C:/Users/lucad/OneDrive/Desktop/CODING FOR DATA SCIENCE/Mobile_Telecomunication_Market")
library(shiny)
library(readxl)
library(rdrobust)
library(ggplot2)
source("functions_app.R")
Dataset_Telecomunication <- read_excel("Dataset_Telecomunication.xlsx")

#User Interface--------------------------------------------------------------------------------
ui <- navbarPage("The Iliad effect",

    tabPanel("Italian Mobile Telecomunication Tariffs",

    sidebarLayout(
        sidebarPanel(width=4,
            column(10,
                   helpText(div(h3("Dependent variable"), style="color:black"),div("Here you can choose the variable to be displayed in the scatterplot."), style="color:black"),
                   selectInput("varselect1", label = h3(""),
                               choices = c("Daily giga", "Daily call minutes", "Daily sms", "Daily cost", "Aggregated quantity", "Giga per euro in tariff", "Call minutes per euro in tariff", "Sms per euro in tariff", "Euros per unit of aggregated quantity"), 
                               selected = "Daily giga"),
                   helpText(div(h3("Days from Iliad entry"), style="color:black"),div("The default range cover the entire dataset displaying mobile plans composition from September 2nd, 2015 to February 22nd, 2021 (exactly 1000 days before and after ",strong("Iliad entry"),").",br(),"You can however change the range and ",strong("zoom")," on determined period."), style="color:black"),
                   sliderInput("periodslider1", h3(""),
                               min = -1000, max = 1000, value = c(-1000,1000))),
                   helpText(div(h3("Operator"), style="color:black"),div("The operators selected by default are the so called ",strong("MNOs")," (those with their own network) while the others are ",strong("MVNOs")," (those without their own network).",br(),"You can choose to display observations of the operator that you want"), style="color:black"),
                   checkboxGroupInput("opercheckgroup1", label = h3(""), 
                               choices = c("Vodafone","TIM","Wind","H3G","Wind Tre","Iliad","CoopVoce","Fastweb","Kena Mobile","PosteMobile", "Spusu", "Tiscali Mobile","UnoMobile","Very Mobile"), selected = c("Vodafone","TIM","Wind","H3G","Wind Tre","Iliad")),
        ),
        
        
        mainPanel(width=8,
            h3("Empirical analysis on price in Italian mobile telecommunication market:",br(), "the Iliad effect"),
            h5("This is an interactive representation of the economic paper", em("'Empirical analysis on price in Italian
            mobile telecommunication market: the Iliad effect'"), ". The paper aims to analyse the effect of the entry of Iliad in the Italian mobile
            telecommunication market and for further knowledge the paper is available ",a("here",href="https://drive.google.com/file/d/1QkuVplG0689dmlMeWsrv58dS4LLyCbOJ/view?usp=sharing"),"."),
            h5(strong("Dependent variable:")),
            h5(textOutput("depvar")),
            h5(strong("Scatterplot:")),
            plotOutput("scatterplot"),
            h5(strong("Brief description of the selected operators:")),
            h5(textOutput("uno")),
            h5(textOutput("due")),
            h5(textOutput("tre")),
            h5(textOutput("quattro")),
            h5(textOutput("cinque")),
            h5(textOutput("sei")),
            h5(textOutput("sette")),
            h5(textOutput("otto")),
            h5(textOutput("nove")),
            h5(textOutput("dieci")),
            h5(textOutput("undici")),
            h5(textOutput("dodici")),
            h5(textOutput("tredici")),
            h5(textOutput("quattordici"))
        )
    )),
    
    tabPanel("Sharp Regression Discontinuity Design",

    sidebarLayout(
        sidebarPanel(width=4,
            column(10,
                   helpText(div(h3("Dependent variable"), style="color:black"),div("Here you can choose the variable on which the ", strong("Sharp RD")," will be performed.",br(),em("'Euros per unit of aggregated quantity'")," is the most representative one."), style="color:black"),
                   selectInput("varselect2", label = h3(""), 
                               choices = c("Daily giga", "Daily call minutes", "Daily sms", "Daily cost", "Aggregated quantity", "Giga per euro in tariff", "Call minutes per euro in tariff", "Sms per euro in tariff", "Euros per unit of aggregated quantity"), 
                               selected = "Euros per unit of aggregated quantity"),
                   helpText(div(h3("Cutoff"), style="color:black"), br(), div("The default ",em("cutoff")," is set to ",strong("zero"), " which correspond exactly to May 29th 2018: when ", strong("Iliad")," entered the market. Changing the cutoff would mean to estimate the effect of a different event that took place near the selected day.",br(),"Note that the effect could always be slightly anticipated or posticipated.",style="color:black")),
                   sliderInput("cutoffslider1", h3(""),
                               min = -500, max = 500, value = 0)),
                   selectInput("polinomselect1", label = h3("Polinomial degree"), 
                               choices = c("1", "2", "3", "4"), 
                               selected = "1")
        ),
        
        mainPanel(width=8,
                  h3("Econometric analysis"),
                  h5(em("Regression discontinuity design"), 
                  " is a quasi experimental pretest/posttest design that supposedly elicits the causal effects 
                    of interventions by assigning a cutoff or threshold above or below which an intervention is assigned. By comparing observations lying 
                    closely on either side of the threshold, it is possible to estimate the average treatment effect. Sharp RD is used when treatment status 
                    is deterministic. In our case the treatment is the European Commission imposition to add a competitor in the Italian telecomunication market 
                    due to the precedent Wind and H3G fusion: the treatment took place on May 29th, 2018 when Iliad entered the market."),
                  h5(strong("Dependent variable:")),
                  h5(textOutput("depvar2")),
                  h5(strong("RD Plot:")),
                  plotOutput("RDD"), 
                  textOutput("coeff")
        )
    ))
    
)

#Server----------------------------------------------------------------------------------------
server <- function(input, output) {
    
#Show a brief description of the selected variable    
    output$depvar <- renderText({
        Dependentvar <- var_descri(input$varselect1)
        paste(Dependentvar)
    
    })
    
#Display the scatterplot representation
    output$scatterplot <- renderPlot({
        z    <-subset(Dataset_Telecomunication, (Dataset_Telecomunication$time_from_iliad_entry>input$periodslider1[1] & Dataset_Telecomunication$time_from_iliad_entry<input$periodslider1[2]) & Dataset_Telecomunication$mobile_network_operator %in% input$opercheckgroup1)
        dependent_variable <- switch (input$varselect1,
                             "Daily giga" = z$daily_giga,
                             "Daily call minutes" = z$daily_calls_mins,
                             "Daily sms" = z$daily_sms,
                             "Daily cost" = z$daily_cost ,
                             "Aggregated quantity" = z$aggregated_index,
                             "Giga per euro in tariff" = z$daily_giga_cost,
                             "Call minutes per euro in tariff" = z$daily_calls_mins_cost,
                             "Sms per euro in tariff" = z$daily_sms_cost,
                             "Euros per unit of aggregated quantity" = z$aggregated_index_cost)
        ggplot(z) + geom_point(aes(x=time_from_iliad_entry, y=dependent_variable, size=daily_cost, 
                                   color=mobile_network_operator)) + labs(title="", x="Days from Iliad entry", 
                                                                          y=input$varselect1) + theme(axis.text.x=element_text(size=15,color="blue"),
                                                                                                      axis.text.y=element_text(size=15,color="blue"),
                                                                                                      axis.title.x=element_text(size=20),
                                                                                                      axis.title.y=element_text(size=20))
    })
    
#Display all the descriptions of the chosen operators
    chosendescri<-reactive({
        descriptionset<-list()
        if (!(is.null(input$opercheckgroup1))){
            for(i in 1:length(input$opercheckgroup1)){
                descriptionset[length(descriptionset)+1]<-operdescri(input$opercheckgroup1[i])
            }
        }
        return(paste(descriptionset,sep="") )
    })
    output$uno <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>0){
            operadescriptions[1]
        }
        else {paste("No operator selected.")}
    })
    output$due <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>1){
            operadescriptions[2]
        }
        else {""}
    })
    output$tre <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>2){
            operadescriptions[3]
        }
        else {""}
    })
    output$quattro <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>3){
            operadescriptions[4]
        }
        else {""}
    })
    output$cinque <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>4){
            operadescriptions[5]
        }
        else {""}
    })
    output$sei <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>5){
            operadescriptions[6]
        }
        else {""}
    })
    output$sette <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>6){
            operadescriptions[7]
        }
        else {""}
    })
    output$otto <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>7){
            operadescriptions[8]
        }
        else {""}
    })
    output$nove <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>8){
            operadescriptions[9]
        }
        else {""}
    })
    output$dieci <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>9){
            operadescriptions[10]
        }
        else {""}
    })
    output$undici <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>10){
            operadescriptions[11]
        }
        else {""}
    })
    output$dodici <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>11){
            operadescriptions[12]
        }
        else {""}
    })
    output$tredici <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>12){
            operadescriptions[13]
        }
        else {""}
    })
    output$quattordici <- renderText({
        operadescriptions<-chosendescri()
        if (length(operadescriptions)>13){
            operadescriptions[14]
        }
        else {""}
    })
        
#Show a brief description of the selected variable
    output$depvar2 <- renderText({
        Dependentvar2 <- var_descri(input$varselect2)
        paste(Dependentvar2)
        
    })

#Display the regression discontinuity plot    
    output$RDD <- renderPlot({
        dependent_variable2 <- switch (input$varselect2,
                                      "Daily giga" = Dataset_Telecomunication$daily_giga,
                                      "Daily call minutes" = Dataset_Telecomunication$daily_calls_mins,
                                      "Daily sms" = Dataset_Telecomunication$daily_sms,
                                      "Daily cost" = Dataset_Telecomunication$daily_cost ,
                                      "Aggregated quantity" = Dataset_Telecomunication$aggregated_index,
                                      "Giga per euro in tariff" = Dataset_Telecomunication$daily_giga_cost,
                                      "Call minutes per euro in tariff" = Dataset_Telecomunication$daily_calls_mins_cost,
                                      "Sms per euro in tariff" = Dataset_Telecomunication$daily_sms_cost,
                                      "Euros per unit of aggregated quantity" = Dataset_Telecomunication$aggregated_index_cost)
        rdplot(y=dependent_variable2, Dataset_Telecomunication$time_from_iliad_entry, c = input$cutoffslider1, 
               p = as.numeric(input$polinomselect1),title="",col.dots = "red",col.lines = "blue", x.label= "Days from Iliad entry",
               y.label=input$varselect2)
    })

#Display a text with the outputs of the corresponding regression discontinuity setting
    output$coeff <- renderText({
        dependent_variable2 <- switch (input$varselect2,
                                       "Daily giga" = Dataset_Telecomunication$daily_giga,
                                       "Daily call minutes" = Dataset_Telecomunication$daily_calls_mins,
                                       "Daily sms" = Dataset_Telecomunication$daily_sms,
                                       "Daily cost" = Dataset_Telecomunication$daily_cost ,
                                       "Aggregated quantity" = Dataset_Telecomunication$aggregated_index,
                                       "Giga per euro in tariff" = Dataset_Telecomunication$daily_giga_cost,
                                       "Call minutes per euro in tariff" = Dataset_Telecomunication$daily_calls_mins_cost,
                                       "Sms per euro in tariff" = Dataset_Telecomunication$daily_sms_cost,
                                       "Euros per unit of aggregated quantity" = Dataset_Telecomunication$aggregated_index_cost)
        rdrobust<-rdrobust(y=dependent_variable2, Dataset_Telecomunication$time_from_iliad_entry, c = input$cutoffslider1, fuzzy = NULL, p = 1)
        coeff<-rdrobust$Estimate[1]
        pv<-rdrobust$pv[1]
        options(scipen=999)
        l<-paste("The estimated coefficient of interest takes value ", round(coeff,digits=3), "and pvalue", round(pv,digits=4))
        if(pv>=0.00500000){paste(l, ". The effect of what happened in day ",input$cutoffslider1, " before Iliad entered the market is statistically NOT significant.")
            
        } else{paste(l,". The effect of what happened ",input$cutoffslider1, " days from Iliad entry on the dependent variable is statistically significant.")
            
        }
    })
}

# Run the application------------------------------------------------------------------------
shinyApp(ui = ui, server = server)
