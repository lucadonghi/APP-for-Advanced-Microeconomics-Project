# Interactive_paper
This Shiny App is an interactive representation of the economic paper "*Empirical analysis on price in Italian mobile telecommunication market: the Iliad effect*". 
This paper has been realized by me and a colleague of mine, Elisabetta Rocchetti, as part of a project for the Advance Microeconomics course. 
It aims to analyse the effect of the entry of Iliad in the Italian mobile telecommunication market and for further knowledge the paper is available [here](https://drive.google.com/file/d/1IrFap4ghJhrOmIcOGX_kO4WO_Zvi2Yl6/view?usp=sharing).

## How to use the Interactive_paper
1. Make sure to install the `shiny` package.
2. Import `shiny` package.
3. If you don't have the other packages installed, running the Shiny App it will automatically check, install and load them. If it doesn't happen make sure to install also the following packages (and to import them): `pacman`, `readxl`, `rdrobust`, `ggplot2`.
4. Type this command in your RStudio console: `runGitHub("Interactive_paper","lucadonghi","master")`

## Shiny App composition
The app consists of two Tab displaying respectively mobile plans dristribution and the econometric analysis
### 1. Italian Mobile Telecomunication Tariffs
This first tab is composed by:
1. Brief description of the Shiny App.
2. The description of the selected dependent variable.
3. The scatterplot showing the distribution of the selected dependent variable on the timeline ("Days from Iliad entry").
4. Short descriptions of the selected operators.

In the sidebar you can choose:
1. The dependent variable of interest among the nine available: this selection will print the respective description and will change the dependent variable in the scatterplot.
2. The time period of interest between the 2000 days available: this choice will change the scatterplot zooming on the selected time period.
3. The mobile operators of which you want to display the observations: it will change the observations plotted in the scatterplot and it will print a short description oof the selected operator.
### 2. Sharp Regression Discontinuity Design
This second tab is composed by:
1. A brief description of the econometric tecnique applied.
2. The description of the selected dependent variable.
3. The Regression Discontinuity Plot of the selected dependent variable on the timeline ("Days from Iliad entry").
4. Short text including the estimated coefficient of interest with its significance level.

In the sidebar you can choose:
1. The dependent variable of interest among the nine available: this selection will print the respective description and will change the dependent variable in the RD Plot and in the Regression Discontinuity coefficient estimation.
2. The cutoff that will be used both in the RD Plot and in the Regression Discontinuity coefficient estimation.
3. The polinomial degree of the RD Plot.

## Files Description
[Dataset_Telecomunication.xlsx](https://github.com/lucadonghi/Interactive_paper/blob/master/Dataset_Telecomunication.xlsx) is the Excel file containing the collected data on which the Shiny App works. Data gathering has been performed for the economical paper drafting and you can find more information about this in the "The_Iliad_effect" PDF file.

[The_Iliad_effect.pdf](https://github.com/lucadonghi/Interactive_paper/blob/master/The_Iliad_effect.pdf) is the economical paper realized as part of a project for the Advance Microeconomics course. The entire Shiny App is based on it.

[functions_app.R](https://github.com/lucadonghi/Interactive_paper/blob/master/functions_app.R) is an R script containing few user-defined functions used "app.R".

[app.R](https://github.com/lucadonghi/Interactive_paper/blob/master/app.R) contains the code used to run Interactive_paper shiny app.
