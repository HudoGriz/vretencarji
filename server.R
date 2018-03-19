library(readxl)
library(png)
library(pracma)
  id <- 1#začetna vrednost ID-ja
  
    #preberi data
  data <- read_excel("Tabela/data.xlsx")
  data$fam <- as.character(data$fam)
  row <- as.vector(data[id,])  #naredi vektor row z samo to vrstico določenega ID-ja
  
server <- function(input, output, session) {

  
  #output$ID <- renderText(row$fam) debug
  
  #output$stat <- renderText(strcmp("captionF",row$fam)) debug
  output$ID <- renderText(id)
  
  observeEvent(input$do, {   #se zažene ob vsakem pritisku knofa PREKONTROLIRAJ
    
    if(strcmp(row$fam, input$captionF)){   #pregleda če si vse prav napiso
  
        if(strcmp(row$species, input$captionS)){
          
          if(strcmp(row$ime, input$captionI)){
            
                  #se ponovi ob vsakem pravilnem vnosu    
                  #izberi vrstico
                      id <<- id + 1
                      
                   # output$ID <- renderText(data$species)  debug
    
                      row <<- as.vector(data[id,]) 
                      output$stat <- renderTable(row)
                  #slika
                      slika <- as.character(row$slika)
    
                      output$image <- renderImage({
                      (list(
                            src = slika,
                            filetype = "image/jpeg",
                            heigth=400, 
                            width=400
                            ))
      
                      },deleteFile = FALSE)
    
                      output$error <- renderText("OPA, DUBAR SI MI SINE!!!")
                      
                    #POČISTI
                      updateTextInput(session,"captionF",value = "")
                      updateTextInput(session,"captionS",value = "")
                      updateTextInput(session,"captionI",value = "")

                          
          }else{
            output$error <- renderText("LUZER, NAPAČNO SLOVENSKO IME!!!")
            output$valueI <- renderText(row$ime)
          }
      
        }else{
          output$error <- renderText("LUZER, NAPAČNA VRSTA!!!")
          output$valueS <- renderText(row$species)
        }
  
  }else{
      output$error <- renderText("LUZER, NAPAČEN ROD!!!")
      output$valueF <- renderText(row$fam)
     
    }
  })

  

  #slika ko se prvič zalaufa
  slika <- as.character(row$slika)

  output$image <- renderImage({
  (list(
        src = slika,
        filetype = "image/jpeg",
        heigth=400, width=400
      ))

  },deleteFile = FALSE)


  
  #debuging
  # output$valueF <- renderText({ input$captionF })
  # output$valueS <- renderText({ input$captionS })
}