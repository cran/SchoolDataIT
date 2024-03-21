#' @keywords internal
#'
Check_connection <- function(){
  while(!curl::has_internet()){
    message("There seems to be no internet connection. Would you wait or abort the operation? \n",
            "    - To hold on for any number of time, press the corresponding number \n",
            "    - To abort the operation, press `A`\n"
)
    holdOn <- readline(prompt = "    ")
    if (toupper(holdOn) == "A") {
      message("You chose to abort the operation. Please try later \n")
      return(FALSE)
    } else {
      n <- as.numeric(holdOn)
      if(is.na(n)) n <- 10
      cat("You chose to wait ", n, " seconds \n")
      Sys.sleep(n)
    }
  }
  return(TRUE)
}
