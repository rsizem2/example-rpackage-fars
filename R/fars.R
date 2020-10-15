#' Reads a file into a dataframe.
#'
#' Helper function for loading FARS data into a dataframe.
#'
#' @param \code{filename} A character string specifying the file from which we want to import data.
#'
#' @return dataframe A dataframe with the contents specified by the filename, if no such file exists, function will raise an error
#'
#' @examples
#' \dontrun{fars_read('data.csv')}
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @export

fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' Returns a valid filename from a given year
#'
#' Helper function that generates a filename string for loading in the FARS data.
#'
#' @param \code{year} integer or object coercible into an integer
#'
#' @return vector A character vector to be used as a filename
#'
#' @examples
#' \dontrun{make_filename('2013')}
#'
#' @export

make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}

#' Reads FARS data for specified years.
#'
#' A helper function which for each given year creates a dataframe with the month and year columns from the original data
#'
#' @param \code{years} A vector or list of strings, or objects coercible into integers representing years
#'
#' @return list A list of dataframes, raises an error if invalid year given
#'
#' @examples
#' \dontrun{fars_read_years(c('2013'))}
#' \dontrun{fars_read_years(c('2013','2014','2015'))}
#'
#' @importFrom dplyr mutate select
#'
#' @export

fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(MONTH, year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' Summarizes accidents per month for each given year
#'
#' Creates a dataframe using the FARS data with a column for each year and a row for each month with the number of accidents in that month.
#'
#' @param \code{years} A vector or list of strings, or objects coercible into integers representing years
#'
#' @return dataframe A dataframe with a column for each year
#'
#' @examples
#' \dontrun{fars_summarize_years(c('2013'))}
#' \dontrun{fars_summarize_years(c('2013','2014','2015'))}
#'
#' @importFrom dplyr group_by summarize
#' @importFrom tidyr spread
#'
#' @export

fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(year, n)
}

#' Plots a visualization of the accidents in the given state.
#'
#' For each state, the accident data is plotted as a point by it's latitude and longitude within the state's borders.
#'
#' @param \code{state.num} An integer or object coercible into an integer, raises an error if state number not found in data
#'
#' @param \code{year} An integer or object coercible into an integer
#'
#' @return NULL
#'
#' @examples
#' \dontrun{fars_map_state(1,'2013')}
#' \dontrun{fars_map_state(21,'2015')}
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @export

fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}