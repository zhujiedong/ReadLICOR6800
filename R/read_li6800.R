#' Title read LI-6800 excel data files.
#'
#' @param data_files path of the LI-6800 data files
#' @param col_names  must be false to make sure the data import
#' @param add_tags whether to add a column that contains a tag, it is ued for batch reading of excel files,
#' default to be true
#' @param tags when add_tags is true, use a characters as a tag,
#' if NULL, use file name as defaut tags.
#' @param ... other paras from read_excel
#' @details
#' note the excel must select Options ---> formula --> Enable iterative calculation,or it will be filled
#' in reading cells that contain formulas
#' @return a data frame of tidy data
#' @export
#'
#' @examples
#' \dontrun{
#' read_li6800('data.xlsx')
#' }


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
