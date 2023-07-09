#' Title read LI-6800 excel data files in batch.
#'
#' @param data_folder path of tthe folder that contains LI-6800 excel data files
#' @param startRow where the header starts, ie the row start with `obs`
#' @param add_tags whether to add a column that contains a tag, it is ued for batch reading of excel files,
#' default to be true
#' @param tags when add_tags is true, use a characters as a tag,
#'  if NULL, use file name as defaut tags.
#' @param ... other paras from read_excel
#' @details note the excel must select Options ---> formula ---> Enable iterative calculation,or it will be filled
#' in reading cells that contain formulas
#'
#' @return a data frame of tidy data
#' @export
#'
#' @examples
#' \dontrun{
#' read_li6800_folder('./data')
#' }

read_li6800_folder <-
  function(data_folder = NULL,
           startRow = 15,
           add_tags = TRUE,
           tags = NULL,
           ...) {
    folder <-
      list.files(data_folder, pattern = "*.xlsx", full.names = TRUE)

    if (!add_tags) {
      message("you may need some lables to distinct data from different files")
      data_list <-
        lapply(folder, read_li6800, add_tags = FALSE, ...)
      df <- do.call(rbind, data_list)
      return(df)

    } else if (add_tags && is.null(tags)) {
      data_list <-
        lapply(folder,
               read_li6800,
               add_tags = TRUE,
               tags = NULL,
               ...)
      df <- do.call(rbind, data_list)
      return(df)
    } else{
      data_list <-
        mapply(read_li6800,
               data_files = folder,
               tags = tags,
               add_tags = TRUE,
               SIMPLIFY = FALSE)
      df <- do.call(rbind, data_list)
      row.names(df) <- NULL
      return(df)
    }
  }
