#library(markdown)
library("shinyURL")
shinyUI(navbarPage("PAT-seq explorer",
                   tabPanel("Genome Coverage",
                            sidebarLayout(
                              sidebarPanel(
                                
                                uiOutput("select_file_path"), 
                                
                                conditionalPanel(
                                  condition = "input.merge == false",
                                  uiOutput("bam_files")
                                  
                                ),
                                conditionalPanel(
                                  condition = "input.merge == true",
                                  uiOutput("select_group")                                
                                ),
                                radioButtons("gene_or_peak", "Find gene or peak", choices=list("Gene"=1, "Peak"=2), selected=1, inline=T),
                                conditionalPanel(
                                  condition= "input.gene_or_peak == 1",
                                  checkboxInput("merge", label = "Combine samples", value = F),
                                  uiOutput("gene_list")
                                ),
                                conditionalPanel(
                                  condition= "input.gene_or_peak == 2",
                                  checkboxInput("merge", label = "Combine samples", value = F),
                                  textInput("select_peak", "Please enter a peak number (as PeakNUM)")
                                ),
                                actionButton("recalc", "Go",),
                                br(),
                                br(),
                                br(),
                                shinyURL.ui(label = "URL containing your search parameters")
                                
                                
                              ),
                              
                              mainPanel(
                                plotOutput("igv_plot"),
                                fluidRow(
                                  column(width = 2,
                                         checkboxInput("spa", label = "Show the Poly (A) tail", value = T)),

                                  column(2,
                                         checkboxInput("all_reads", label = "Include reads that do not have a 
                  poly (A)-tail", value = F)),
                                  column(3,
                                         sliderInput("al_length", label= 'Aligned reads length range', min=0, max=400,
                                                     value =c(0,400))),
                                  column(4,
                                         sliderInput("ad_slider", label= "Number of sequenced adpater bases", min=0, max=23,
                                                     value =0, step = 1,ticks = TRUE, 
                                                     sep = ",")),
                                  column(1,
                                         downloadButton("downloadPlot_igv", label = "Download EPS"))
                                         
                                  
                                  
                                )
                              )
                            )
                            
                   ),
                   tabPanel("Raw read count",                            
                            mainPanel(
                              plotOutput("gene_expression_plot")                                
                            )
                   ),
                   tabPanel("Poly (A)-tail cumulative distribution",                        
                            
                            
                            plotOutput('scp_plot'),
                            fluidRow(
                              column(1,
                                      checkboxInput("legend", label = "Display a legend on the plot", value = T)),
                              column(2,
                                     sliderInput("xslider", label= 'x axis slider', min=0, max=400,
                                                 value =c(0, 300), step = 25,ticks = TRUE, 
                                                 sep = ",")),
                              column(3,
                                     downloadButton("downloadPlot", label = "Download EPS"))
                              
                            )
                            
                            
                   ),
                   tabPanel("Read Length Cumulative Distribution",
                            
                            
                              plotOutput("pilup_plot"),
                            fluidRow(
                              column(1,
                              checkboxInput("legend_2", label = "Display a legend on the plot", value = T)
                              ),
                              column(2,
                              sliderInput("xslider_2", label= 'x axis slider', min=0, max=400,
                                          value =c(0, 300), step = 25,ticks = TRUE, 
                                          sep = ",")
                              ),
                              column(3,
                                     downloadButton("downloadPlot_2", label = "Download EPS"))
                              
                            )
                            
                   ),
                   tabPanel("Additional summary statistics",
                            
                            mainPanel(
                              dataTableOutput("means_frame"),
                              dataTableOutput("gff_rows"),
                              dataTableOutput('print_poly_a_counts')
                            )
                   ),
                   
                   tabPanel("Help",
                            
                            mainPanel(
                              verbatimTextOutput("help_text")
                              
                            )
                            
                   )
))


#                                     tags$style(type="text/css",
#                                                ".shiny-output-error { visibility: hidden; }",
#                                                ".shiny-output-error:before { visibility: hidden; }"
#        