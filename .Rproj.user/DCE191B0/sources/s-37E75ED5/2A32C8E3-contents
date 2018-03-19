library(shiny)

fluidPage(
  #slika

  imageOutput("image", height = 400 ),

  #tekst
  textInput("captionF", "Rod"),
  verbatimTextOutput("valueF"),  # za debuging

  textInput("captionS", "Vrsta"),
  verbatimTextOutput("valueS"),  # za debuging

  textInput("captionI", "Ime"),
  verbatimTextOutput("valueI"),  # za debuging
  
  #tableOutput("stat"), # za debuging
    #gumb
  actionButton("do", "Prekontroliraj"),
  
    #Error
  h3(textOutput("error"))
  
  #verbatimTextOutput("ID") # za debuging
)