#' Download the names and codes of Italian LAU and NUTS-3 administrative units
#'
#' @description This function downloads a file provided by the Italian National Institute of Statistics including all the codes of administrative units in Italy. As of today, it is the easiest way to map directly cadastral codes to municipality codes.
#'
#' @param Year Numeric or character value. Last available is 2024.
#' For coherence with school data, it is also in the formats: \code{2023}, \code{"2022/2023"}, \code{202223}, \code{20222023}. \code{2023} by default.
#' @param date Character. The reference date, in format \code{"mm_dd"}, either \code{"01_01"} \code{"06_30"},
#' or \code{"09_01"} (close to the beginning of the school year). \code{"01_01"} by default.
#' @param autoAbort Logical. Whether to automatically abort the operation and return NULL in case of missing internet connection or server response errors. \code{FALSE} by default.
#'
#' @return An object of class \code{tbl_df}, \code{tbl} and \code{data.frame}, including: NUTS-3 code, NUTS-3 abbreviation,
#' LAU code, LAU name (description) and cadastral code. All variables are characters except for the NUTS-3 code.
#'
#' @examples
#'
#' Get_AdmUnNames(2024, autoAbort = TRUE)
#'
#'
#' @source <https://situas.istat.it/web/#/territorio>
#'
#' @export



Get_AdmUnNames <- function(Year = 2023, date = "01_01", autoAbort = FALSE){


  if(!Check_connection(autoAbort = autoAbort)) return(NULL)

  pattern0 <- "https://raw.githubusercontent.com/lcef97/ISTAT_AdmUnNames/main/ISTAT_AdmUnNames"

  while(!date %in% c("01_01", "06_30", "09_01")) {
    message("Please, choose either '01_01', '06_30' or '09_01' as date")
    date <- readline(prompt = "  > ")
  }
  while(!as.numeric(Year) %in% c(2015:2024)){
    message("Please, choose a year between 2015 and 2024")
    year <- readline(prompt = "  > ")
  }
  Year <- 2000 + as.numeric(year.patternA(Year))%%100
  pattern1<- paste0(Year, "_", date, ".CSV")

  url <- paste0(pattern0, "/", Year, "/", pattern1)

  DB <- NULL
  attempt <- 0
  while(is.null(DB) && attempt <= 10){
    DB <- tryCatch({
      readr::read_delim(url, delim = ";", show_col_types = FALSE)
    }, error = function(e){
      message("Cannot read the file; ", 10 - attempt,
              " attempts left. If the problem persists, please contact the maintainer.\n")
      return(NULL)
    })
    attempt <- attempt + 1
  }
  if(is.null(DB)) return(NULL)

  res <- DB %>%
    dplyr::select(.data$`Codice Provincia (Storico)`, .data$`Sigla automobilistica`,
                  .data$`Codice Comune (alfanumerico)`, .data$`Comune`,
                  .data$`Codice catasto`)
  names(res) <- c("Province_code", "Province_initials","Municipality_code",
                  "Municipality_description", "Cadastral_code")

  res$Province_code <- as.numeric(res$Province_code)
  res$Province_initials[which(res$Province_code == 63)] <- "NA"

  return(res)
}
