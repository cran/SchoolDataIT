#' Subset of the administrative codes of municipalities
#'
#'
#' This table includes the administrative codes of the municipalities from four regions: Molise, Campania, Apulia and Basilicata,
#' as of June 30th 2022; some strings in field \code{Municipality_description} including accents have been forced to ASCII.
#' The whole dataset can be retrieved with the command \code{Get_AdmUnNames(Date = "2022-06-30")}
#' @seealso \code{\link{Get_AdmUnNames}}
#'
#' @format ## `example_AdmUnNames20220630`
#' A data frame with 1,074 rows and 5 columns:
#' \itemize{
#'   \item \code{Province_code} Numeric; the NUTS-3 administrative code
#'   \item \code{Province_initials} Character;abbreviated NUTS-3 denomination.
#'   \item \code{Municipality_code} Character; the ISTAT LAU (municipality) ID.
#'   \item \code{Municipality_description} Character; the municipality name.
#'   \item \code{Cadastral_code} Character; a LAU - level ID code, different from the official ISTAT municipality code.
#'   It is used in the school registry (see \code{\link{example_input_Registry23}})
#' }
#' @source <https://www.istat.it/it/archivio/6789>
"example_AdmUnNames20220630"
