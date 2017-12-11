library(shiny)

shinyUI(fluidPage(
  titlePanel("eDNA detection probability calculator"),
  p("This estimator uses a simple model of environmental DNA detection of stream fishes
    from Wilcox et al. (2016). Here, the the user specifies the
    sampling distance downstream from a fixed number of individuals. The model relies
    on several assumptions which may or may not be reasonable in your study system. Below
    each parameter estimate slider is a brief description and a note on some of the assumptions. 
    Please see the original paper for more detail: Wilcox, T. M., K. S. McKelvey, M. K. Young, 
    A. J. Sepulveda, B. B. Shepard, S. F. Jane, A. R. Whiteley, W. H. Lowe, and M. K. Schwartz. 
    2016. Understanding environmental DNA detection probabilities: a case study using a stream-dwelling 
    char (Salvelinus fontinalis). Biological Conservation 194:209-216."),
  p("A possible use of this estimator is to help in planning sampling effort for a pilot study. Another
    potential application is to initially explore what sampling and analysis optimizations are likely
    to provide the most cost-effect improvement in detection probability. As you can see from moving
    the sliders around, detection probability estimates can be very sensitive to parameter estimates. This
    is another reason to interpret results from this calculator with caution."),
  
  sidebarLayout(
    sidebarPanel( h1("Parameter estimates"),
                  p("Default parameters from Wilcox et al. 2016."),
                  
                  sliderInput("fish", 
                              label = "Number of animals",
                              min = 1, max = 50, value = 1),
                  p("Assumes that all individuals are identical."),
                
                  sliderInput("distance", 
                              label = "Hundreds of meters upstream",
                              min = 0, max = 10, value = 0),
                  p("Assumes that all individuals are equally and exactly n hundred meters upstream."),
                  
                  sliderInput("production", 
                              label = "Target DNA copies/individual/second",
                              min = 1, max = 2000, value = 495),
                  p("How many copies of DNA are released per individual per second? Assumes that all individuals release DNA into the environment at a constant rate."),
                  
                  sliderInput("persistence", 
                              label = "Proportion eDNA persists/100 m",
                              min = 0, max = 1, value = 0.63, step = 0.01),
                  p("What proportion of the eDNA that your animal produces persists per 100 meters of downstream transport in a stream? Assumes that eDNA declines in concentration exponentially with distance."),
                  
                  sliderInput("discharge", 
                              label = "Stream discharge (L/second)",
                              min = 1, max = 200, value = 65),
                  p("Assumes that stream discharge affects eDNA dilution only and not it's production, transport, or decay rate."),
                  
                  sliderInput("sample_volume", 
                              label = "Sample volume (L)",
                              min = 0.1, max = 10, value = 2.5, step = 0.1),
                  p("For example, if you pump 5 L of water through a filter, then extract DNA from one half of the filter, you have sampled 2.5 L."),
                  
                  sliderInput("extraction_eff", 
                              label = "Extraction efficiency",
                              min = .1, max = 2, value = 1, step = 0.1),
                  p("Relative DNA extraction efficiency. '1' assumes you use the same extraction method as was used to estimate eDNA production rate per individual. > 1 means that you have improved your extraction efficiency."),
                  
                  sliderInput("proportion_PCR", 
                              label = "Proportion extraction/PCR rxn",
                              min = 0.01, max = 1, value = 0.04, step = 0.01),
                  p("What proportion of your extracted DNA elution goes into each PCR reaction? For example, using 4 microliters template per reaction from a 100 microliter elution = 0.04."),
                  
                  sliderInput("PCR_reps", 
                              label = "PCR replicates",
                              min = 1, max = 10, value = 3),
                  p("For example, triplicate PCR = 3."),
                  
                  sliderInput("PCR_amp", 
                              label = "PCR amplification probability",
                              min = 0.5, max = 1, value = 0.8),
                  p("What is your per/DNA copy probability of amplification? This could be estimated from a standard curve experiment and it varies among PCR assays. See Wilcox et al. 2016 or Furlan et al. 2015 for more detail.")
                  
                              ),
    mainPanel(
      textOutput("text1")
    )
  ) 
))