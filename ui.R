library(shiny)

fluidPage(
  #slika

  imageOutput("image", height = 400 ),

  #tekst
  textInput("captionF", "Druzina"),
  verbatimTextOutput("valueF"),  # za debuging

  textInput("captionS", "Vrsta"),
  verbatimTextOutput("valueS"),  # za debuging

  textInput("captionI", "Ime"),
  verbatimTextOutput("valueI"),  # za debuging
  
  #tableOutput("stat"), # za debuging
    #gumb
  actionButton("do", "Prekontroliraj"),
  textOutput("navodila"),
  
    #Error
  h3(textOutput("error")),
  radioButtons("roc", "Povrsti ali random?",
               c("random" = "rand",
                 "povrsti" = "norm")
               ),
   checkboxGroupInput("select", "zelim resevati:",
                        c("ribe", "ptici", "dvozivke", "sesalci", "plazilci"),
                      selected =c("ribe", "ptici", "dvozivke", "sesalci", "plazilci")
                      )
  
                 
  
  #verbatimTextOutput("ID") # za debuging
)