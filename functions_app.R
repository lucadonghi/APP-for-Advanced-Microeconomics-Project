var_descri<-function(variable){
return(switch (variable,
        "Daily giga" = "'Daily giga' is a variable representing how many gigabytes per day were offered in any
                                       mobile plan",
        "Daily call minutes" = "'Daily call minutes' is a variable representing how many minutes of call per day were offered in any
                                       mobile plan",
        "Daily sms" = "'Daily sms' is a variable representing how many sms per day were offered in any
                                       mobile plan",
        "Daily cost" = "'Daily cost' is a variable representing how much did any mobile plan cost on daily basis" ,
        "Aggregated quantity" = "'Aggregated quantity' is a compound variables obtained adding together daily giga, daily call minutes
                                                and daily sms previously normalized. This is a way to display the total quantities offered in a mobile 
                                                plan assuming that any of the three components have the same weight.",
        "Giga per euro in tariff" = "'Giga per euro in tariff' is a variable representing how many gigabytes 
                                                    were offered in any mobile plan for every euros of cost. It represents
                                                    quantity/price ratio",
        "Call minutes per euro in tariff" = "'Call minutes per euro in tariff' is a variable representing how many minutes of call 
                                                    were offered in any mobile plan for every euros of cost. It represents
                                                    quantity/price ratio",
        "Sms per euro in tariff" = "'Sms per euro in tariff' is a variable representing how many sms 
                                                    were offered in any mobile plan for every euros of cost. It represents
                                                    quantity/price ratio",
        "Euros per unit of aggregated quantity" = "'Euros per unit of aggregated quantity' is a variable representing the ratio 
                                                                      between the daily cost and the aggregated quantity. This is a way to display the 
                                                                      euros of cost per any unit of aggregated quantity: the price/quantity ratio. 
                                                                      This variable shows in the most complete form how much the costumer has to pay for 
                                                                      the service in the different time period.")
)}

operdescri<-function(operator){
  return(switch(operator,
                "Vodafone"="Vodafone Italia is a Mobile Network Operator was born in 2002 when Vodafone took control of Omnitel and created the company 'Vodafone Omnitel'. It has approximately 26,000,000 mobile customers with a market share of 29,5% placing itself behind Wind Tre and TIM.",
                "TIM"="TIM is a Mobile Network Operator founded in 1994 by the merger of several state-owned telecommunications companies, the most prominent of which was 'Società Italiana per l'Esercizio Telefonico', the former state monopoly telephone operator in Italy . It is the largest Italian telecommunications services provider in revenues and subscribers.",
                "Wind"="Wind was a Mobile Network Operator established in 1997 by the Italian Electrical Company 'Enel'. Wind Italy had 21.6 million mobile customers with a market share of 22.9% placing itself behind TIM and Vodafone Italy. On December 31st, 2016, Wind merged with 3 Italy to form Wind Tre.",
                "H3G"="H3G, commonly known as 'Tre Italia' or '3', was a Mobile Network Operator born in 2003. On December 31st, 2016 it merged with Wind founding 'Wind Tre'. H3G, before the merger with Wind, was the fourth mobile telephone operator in Italy by number of subscribers (11% of the market) placing itself behind TIM, Vodafone and Wind.",
                "Wind Tre"="Wind Tre is a Mobile Network Operator born on December 31st, 2016 from the merger of Wind and H3G. It has 27.1 million mobile customers with a market share of 30.8% placing itself ahead TIM (only in the mobile market), Vodafone Italia and Iliad Italia.",
                "Iliad"="Iliad is a Mobile Network Operator founded in 2016 as an Italian subsidiary of the French group Iliad. In 2017, in view of the launch and in compliance with the provisions of the European Commission, the acquisition of the frequencies ceased by Wind Tre began following the merger of Wind and 3 Italia. It is the fourth mobile operator in Italy following Wind Tre, TIM and Vodafone Italy.",
                "CoopVoce"="CoopVoce is the first Virtual Mobile Network Operator launched in Italy. It has been operational since since June 1st, 2007 and after an experimental phase lasting about three months, it was born from the agreement between Coop Italia and TIM of which it uses the network infrastructures to provide the service.",
                "Fastweb"="Fastweb is a Virtual Mobile Network Operator operational in the mobile telecomunication market since 2008. It uses Wind Tre network infrastructures in order to provide the service.",
                "Kena Mobile"="Kena Mobile is a Virtual Mobile Network Operator born on March 30th, 2017. It is a brand of TIM and therefore it uses its network infrastructures.",
                "PosteMobile"="Postemobile is a Virtual Mobile Network Operator launched on November 26th 2007. It now uses Wind Tre network infrastructures.",
                "Spusu"="Spusu is a Virtual Mobile Network Operator born on June 15th, 2020. It uses Wind Tre network infrastructures.",
                "Tiscali Mobile"="Tiscali Mobile is a Virtual Mobile Network Operator operational since March 25th, 2009. It uses TIM network infrastructures.",
                "UnoMobile"="UnoMobile is a Virtual Mobile Network Operator born June 7th, 2007. It uses Vodafone network infrastructures.",
                "Very Mobile"="Very Mobile is a Virtual Mobile Network Operator born on February 24th, 2020. It uses Wind Tre network infrastructures.")
  )}
