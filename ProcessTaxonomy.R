
setwd("<Set Working Directory Path>")
library("collapsibleTree")
library("readxl")
library("colorspace")

process_network <- read_excel("ProcessHierarchyNetwork.xlsx",range = cell_cols("A:E"))
process_network[is.na(process_network[["AlternativeNames"]]),"AlternativeNames"]="None"
process_network[is.na(process_network[["Function"]]),"Function"]="None"
process_network[is.na(process_network[["Identifier"]]),"Identifier"]="None"

process_network$ColorVal <- factor(process_network$Function)
levels(process_network$ColorVal) <- colorspace::rainbow_hcl(13)

process_network$tooltip <- paste0(
  process_network$Process,
  "<br>Alternative Names: ",
  process_network$AlternativeNames,
  "<br>Function Type: ",
  process_network$Function,
  "<br>Identifier: ",
  process_network$Identifier
)

collapsibleTreeNetwork(
  process_network,
  attribute = "AlternativeNames",
  fill = "ColorVal",
  tooltipHtml = "tooltip",
  width = 1000
)

