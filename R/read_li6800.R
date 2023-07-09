#' Title read LI-6800 excel data files.
#'
#' @param data_files path of the LI-6800 data files
#' @param startRow where the header starts, ie the row start with `obs`
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


read_li6800 =
  function(data_files,
           startRow = 15,
           add_tags = TRUE,
           tags = NULL,
           ...) {
    df = openxlsx::read.xlsx(data_files, startRow = 15, ...)
    df = df[-1,]
    if (!add_tags) {
      return(df)
    } else if (add_tags && is.null(tags)) {
      df$data_tag = gsub(".xlsx", "", basename(data_files))
      return(df)
    } else {
      df$data_tag = tags
      return(df)
    }
  }
