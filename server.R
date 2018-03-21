library(readxl)
library(png)
library(pracma)

  
  
  
server <- function(input, output, session) {
  data <- read_excel("Tabela/data.xlsx")
  data2 <- data
  id <- floor(runif(1, min=0, max=nrow(data)))#začetna vrednost ID-ja
  #preberi data
  data$kdo <- as.character(data$kdo)
  data$fam <- as.character(data$fam)
  row <- as.vector(data2[id,])  #naredi vektor row z samo to vrstico določenega ID-ja
  #output$ID <- renderText(row$fam) debug

  #poaži določene žvadi
  
  observeEvent(input$select,{
    ker <- input$select
    data2    <<- data[data$kdo %in% ker,]
    
  
    #output$stat <- renderTable(data2)
    })

  output$ID <- renderText(id)
  
  observeEvent(input$do, {   #se zažene ob vsakem pritisku knofa PREKONTROLIRAJ
    
    if(strcmp(row$fam, input$captionF)){   #pregleda če si vse prav napiso
  
        if(strcmp(row$species, input$captionS)){
          
          if(strcmp(row$ime, input$captionI)){
            
                  #se ponovi ob vsakem pravilnem vnosu    
                  #izberi vrstico
                      
                    if(strcmp(input$roc, "norm")){
                      id <<- id + 1
                      
                      if (id>nrow(data2)){id <<- 1}}else{
                        
                        id <<- floor(runif(1, min=1, max=nrow(data2)))
                      }
            
                      
                   # output$ID <- renderText(data$species)  debug
    
                      row <<- as.vector(data2[id,]) 
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
                      
                      output$valueI <- renderText({NULL})
                      output$valueS <- renderText({NULL})
                      output$valueF <- renderText({NULL})

                          
          }else{
            output$error <- renderText("LUZER, NAPACNO SLOVENSKO IME!!!")
            output$valueI <- renderText(row$ime)
          }
      
        }else{
          output$error <- renderText("LUZER, NAPACNA VRSTA!!!")
          output$valueS <- renderText(row$species)
        }
  
  }else{
      output$error <- renderText("LUZER, NAPACNA DRUZINA!!!")
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
  
  output$navodila <- renderText("Navodila: pisi vse z malimi, ne pisi sumnikov, pa nebi smelo bit komplikacij")
  
  #keep alive
  
  output$keepAlive <- renderText({
    req(input$count)
    paste("keep alive ", input$count)
  })


  
  #debuging
  # output$valueF <- renderText({ input$captionF })
  # output$valueS <- renderText({ input$captionS })
}