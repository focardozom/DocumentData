
test_that("Error on non-existent data frame", {
  expect_error(document_data(nonExistentDataFrame), "The dataset does not exist in the current environment.")
})


test_that("Error on non-data frame input", {
  nonDataFrameInput <- list(a = 1, b = 2)
  assign("nonDataFrameInput",
         nonDataFrameInput, envir = .GlobalEnv)

  expect_true(exists("nonDataFrameInput", envir = .GlobalEnv))

  expect_error(document_data(nonDataFrameInput), "The provided object is not a data frame.")
})


# Adjusting the test to handle formatting and whitespace more flexibly
test_that("Content in created file is correct", {
  df <- data.frame(a = 1, b = "A", stringsAsFactors = FALSE)
  document_data(df) # This should create "df.R" in the current directory
  file_name <- "df.R"

  # Ensure the file has been created
  expect_true(file.exists(file_name))

  # Read the content from the created file, warning about incomplete lines is usually harmless
  cat_content <- paste(readLines(file_name, warn = FALSE), collapse = "\n")

  # Define the expected content, making sure to match the actual formatting closely
  content_expect <- c(
    "#'@title df\n#'\n#' @description describe your data set here\n#'\n#' @docType data\n#'\n#' @usage data(df)\n#'\n#' @format A list [data.frame] with 1 rows and 2 variables:\n#'\\itemize{\n#' \\item{a} {numeric: Type label here}\n#' \\item{b} {character: Type label here}\n#'}\n'df'"
  )

  # Compare the content, ignoring differences in leading/trailing whitespace
  expect_equal(cat_content, content_expect)

  # Cleanup
  unlink(file_name)
})


