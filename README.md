# Interactive_paper
This Shiny App is an interactive representation of the economic paper 'Empirical analysis on price in Italian mobile telecommunication market: the Iliad effect'. 
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
1. A brief description of the Shiny App.
2. The description of the selected dependent variable.
3. The scatterplot showing the distribution of the selected dependent variable (corrisponding to the selected operators mobile telecomunication plans) on the timeline ("Days from Iliad entry").
4. The short descriptions of the selected operators.

In the sidebar you can choose:
1. The dependent variable of interest among the nine available: this selection will print the respective description and will change the dependent variable in the scatterplot.
2. The time period of interest between the 2000 days available: this choice will change the sca
