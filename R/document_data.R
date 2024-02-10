#' Document Data
#'
#' @description
#' `document_data` creates an .R file containing detailed documentation
#' of a provided dataset. It automatically generates a template including
#' variables' names, data types, row and column counts, and placeholders for further description.
#'
#' @param x A dataset loaded in the R environment. The function extracts its
#' name, type, class, dimensions, and column names for documentation.
#'
#' @return This function generates an R script named after the dataset,
#' which includes a structured documentation template. The template
#' consists of the dataset's basic information and placeholders for detailed descriptions.
#'
#' @export
#' @name document_data
#' @examples
#' \dontrun{
#' the_data <- as.data.frame(datasets::Titanic)
#' document_data(the_data)
#' }
#' @md
NULL

document_data <- function(x) {
  if (!exists(deparse(substitute(x)))) {
    stop("The dataset does not exist in the current environment.")
  }

  if (!is.data.frame(x)) {
    stop("The provided object is not a data frame.")
  }

  dataset_name <- deparse(substitute(x))
  data_description <- create_data_description(x, dataset_name)
  file_name <- paste0("./", dataset_name, ".R")
  cat(data_description, file = file_name)
}

#' Create Data Description
#'
#' Generates a detailed description of a dataset, including information about
#' its type, class, dimensions (rows and columns), and a placeholder for each
#' variable's description. This description is formatted as a string that could
#' be used directly in R documentation files or other descriptive materials.
#'
#' @param dataset A data frame for which the description is to be generated.
#' @param name The name of the dataset, which will be used in the title and usage
#'        sections of the generated description.
#'
#' @return A character string containing the structured documentation template
#'         for the dataset. This includes the dataset's basic information and
#'         placeholders for detailed descriptions of each variable.
#'
#' @examples
#' data(mtcars)
#' description <- create_data_description(mtcars, "mtcars")
#' cat(description)
#'
#' @export

generate_data_info <- function(dataset) {
  paste0(
    "A ", typeof(dataset), " [", class(dataset), "] with ",
    nrow(dataset), " rows and ", length(names(dataset)), " variables:\n"
  )
}

generate_variable_descriptions <- function(dataset) {
  sapply(names(dataset), function(var) {
    paste0("\\item{", var, "} {", class(dataset[[var]]), ": Type label here}")
  }, USE.NAMES = FALSE)
}

create_data_description <- function(dataset, name) {
  data_info <- generate_data_info(dataset)
  variable_descriptions <- generate_variable_descriptions(dataset)

  description_template <- paste0(
    "#'", "@", "title ", name, "\n#'\n#' ", "@", "description describe your data set here\n#'\n#' ",
    "@", "docType data\n#'\n#' ", "@", "usage data(", name, ")\n#'\n#' ",
    "@", "format ", data_info, "#'\\itemize{\n#' ", paste(variable_descriptions, collapse = "\n#' "),
    "\n#'}\n", "'", name, "'"
  )

  return(description_template)
}

