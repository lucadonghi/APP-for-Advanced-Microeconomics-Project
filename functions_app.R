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
                "Vodafone"="Vodafone Italia S.p.A. is an Italian telephone company, which has approximately 26,000,000 mobile customers with a market share of 29,5%.",
                "TIM"="TIM",
                "Wind"="wind",
                "H3G"="H3G",
                "Wind Tre"="wind tre",
                "Iliad"="iliad",
                "CoopVoce"="coopvoce",
                "Fastweb"="fastweb",
                "Kena Mobile"="kena mobile",
                "PosteMobile"="postemobile",
                "Spusu"="spusu",
                "Tiscali"="tiscali",
                "UnoMobile"="unomobile",
                "Very Mobile"="very mobile")
  )
}