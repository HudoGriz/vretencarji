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
                      ),
  #keep alive
  tags$head(
    HTML(
      "
          <script>
          var socket_timeout_interval
          var n = 0
          $(document).on('shiny:connected', function(event) {
          socket_timeout_interval = setInterval(function(){
          Shiny.onInputChange('count', n++)
          }, 15000)
          });
          $(document).on('shiny:disconnected', function(event) {
          clearInterval(socket_timeout_interval)
          });
          </script>
          "
    )
  ),
  textOutput("keepAlive")
                 
  
  #verbatimTextOutput("ID") # za debuging
)