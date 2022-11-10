# DocumentData

A package created to document datasets

# Install

To install my package use this code

```
devtools::install_github("focardozom/DocumentData")
```

# Example

This is a simple example of how the `document_data` function will create a file in your directory with the roxygen skeleton. 

```
the_data <- as.data.frame(datasets::Titanic)
document_data(the_data)
```
