test_that("generate data description", {

  df <- data.frame(a = 1, b = "A")

  data_info <- generate_data_info(df)

  expect_equal(data_info, "A list [data.frame] with 1 rows and 2 variables:\n")

})


test_that("Generate variable description", {

  df <- data.frame(a = 1)

  var_info <- generate_variable_descriptions(df)

  expect_equal(var_info, "\\item{a} {numeric: Type label here}")

})


test_that("Template capture info", {
  df <- data.frame(a = 1)

  template <- create_data_description(df, "df")
  output <- "#'@title df\n#'\n#' @description describe your data set here\n#'\n#' @docType data\n#'\n#' @usage data(df)\n#'\n#' @format A list [data.frame] with 1 rows and 1 variables:\n#'\\itemize{\n#' \\item{a} {numeric: Type label here}\n#'}\n'df'"

  expect_equal(template, output )


})

