---
title: "Shiny app"
author: "Priya Singh"
date: "03/08/2024"
output:
  word_document: default
  html_document:
    df_print: paged
---
## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


Load Shiny
```{r setup, include=FALSE}
library(shiny)
```

Create User Interface
```{r setup, include=FALSE}

ui <- fluidPage("Hello World")

```

Create a server 
```{r setup, include=FALSE}

server <- function(input, output){}

```


Create a shiny app
```{r setup, include=FALSE}
shinyApp(
  ui = ui,
  server = server
)

```

create a UI with I/O controls 
```{r setup, include=FALSE}
ui <- fluidPage(
  titlePanel("Input and Output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "num",
        label = "Choose a number",
        min = 0,
        max = 100, 
        value = 25)),
    mainPanel(
      textOutput(
        outputId = "text"))))
      
```


Create a server that maps input to output 
```{r setup, include=FALSE}
server <- function(input, output){
  output$text <- renderText({
    paste("you selected", input$num)
  })
}
  
```

Create a shiny app
```{r iris}
shinyApp(
  ui = ui,
  server = server
)
```


Load decision tree package 
```{r setup, include=FALSE}
library(tree)

```


Load training data 
```{r}
load("Train.RData")
```

Load tree model
```{r setup, include=FALSE}

load("Tree.RData")

```

Load color brewer library 
```{r setup, include=FALSE}

library(RColorBrewer)

#create color palette
color_palette <- brewer.pal(3, "Set2")

```

Create user interface code 
```{r}
ui <- fluidPage(
  titlePanel("Iris Species Predictor"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "Petal.Length",
        label = "Petal Length(cm)",
        min = 1, 
        max = 7, 
        value = 4),
      sliderInput(
        inputId = "Petal.Width",
        label = "Petal Width(cm)",
        min = 0.0, 
        max = 2.5,
        step = 0.5,
        value = 1.5)),
    mainPanel(
      textOutput(
        outputId = "text"),
      plotOutput(
        outputId = "plot"))))
      
```

Create server code
```{r}
server <- function(input, output){
  output$text = renderText({
    
    #create predictors
    predictors <- data.frame(
      Petal.Length = input$Petal.Length,
      Petal.Width = input$Petal.Width,
      Sepal.Length = 0,
      Sepal.Width = 0)
    
    #Make prediction
    prediction = predict(
      object = model,
      newdata = predictors,
      type = "class")
    
    #create prediction text 
    paste(
      "The predicted species is ",
      as.character(prediction))
    })
  output$plot = renderPlot({
    
  
    #Create a scatterplot colored by species 
    plot(
      x = iris$Petal.Length,
      y = iris$Petal.Width,
      pch = 19, 
      col = color_palette[as.numeric(iris$Species)],
      main = "Iris Petal Length vs width",
      xlab = "Petal Length(cm)",
      ylab = "Petal Width (cm)")
    
    #plot decision boundaries 
    partition.tree(
      tree = model, 
      label = "Species",
      add = TRUE )
    
    #draw predictor on plot
    points(
      x = input$Petal.Length, 
      y = input$Petal.Width, 
      col = "red",
      pch = 4,
      cex = 2,
      lwd = 2)
  })
}

```

create shiny app
```{r}

shinyApp(
  ui = ui, 
  server = server
)

```
