library(shiny)

shinyServer(
  function(input, output) {
    #modified and abreviated detection model from Wilcox et al. 2016 in Biological Conservation
    lambda <- reactive(as.numeric((input$fish*input$production*input$persistence^input$distance)/input$discharge*input$sample_volume*input$extraction_eff*input$proportion_PCR*input$PCR_reps))                      
    amp <- reactive(as.numeric(1-input$PCR_amp))                
    p <- reactive(1-sum(                 
                         (amp()^0)*dpois(0,lambda()),  
                         (amp()^1)*dpois(1,lambda()),
                         (amp()^2)*dpois(2,lambda()),
                         (amp()^3)*dpois(3,lambda()),
                         (amp()^4)*dpois(4,lambda()),
                         (amp()^5)*dpois(5,lambda()),
                         (amp()^6)*dpois(6,lambda()),
                         (amp()^7)*dpois(7,lambda()),
                         (amp()^8)*dpois(8,lambda()),
                         (amp()^9)*dpois(9,lambda()),
                         (amp()^10)*dpois(10,lambda())))
                
    output$text1 <- renderText({ 
      paste("Estimated detection probability =", p())
    })
    
  }
)