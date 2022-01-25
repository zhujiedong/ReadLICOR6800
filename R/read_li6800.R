read_li6800 <-
  function(data_files,
           col_names = FALSE,
           add_tags = TRUE,
           tags = NULL,
           ...) {
    df <- readxl::read_excel(data_files, ...)
    df <- data.frame(df)
    header_n <- which(df[1] == "obs")

    df <- df[-(1:(header_n - 1)), ]
    df <- df[-2,]

    names(df) <- df[1,]
    df <- df[-1,]
    df <- df[which(df$obs > 0),]

    if (!add_tags) {
      return(df)
    } else if (add_tags && is.null(tags)) {
      df$data_tag <- gsub(".xlsx", "", basename(data_files))
      return(df)
    } else {
      df$data_tag <- tags
      return(df)
    }

  }
