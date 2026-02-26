#' Calculate Catch per unit effort (CPUE)
#'
#' Calculate Catch per unit effort (CPUE) as catch divided by effort, optionally adjusting for gear standardization.
#'
#' @param catch Numeric vector of catch
#' @param effort Numeric vector of effort
#' @param gear_factor Numeric adjustment for gear standardize
#' @param verbose Logical value to show messages (default is FALSE, use fishr.verbose option to set globally)
#' @param method
#'
#' @returns a numeric, vector of CPUE values
#' @export
#'
#' @examples
#' cpue(100,10)
#' cpue(100, 10, gear_factor=0.5)
cpue <- function(
  catch,
  effort,
  gear_factor = 1,
  method = c("ratio", "log"),
  verbose = getOption("fishr.verbose", default = FALSE)
) {
  validate_numeric_inputs(catch = catch, effort = effort)
  if (verbose) {
    message("Processing ", length(catch), " records")
  }

  method <- match.arg(method)
  raw_cpue <- switch(
    method,
    ratio = catch / effort,
    log = log(catch / effort)
  )
  result <- raw_cpue * gear_factor
  attr(result, "gear_factor") <- gear_factor
  attr(result, "n_records") <- length(catch)
  attr(result, "method") <- method
  class(result) <- "cpue_result"
  return(result)
}

#' @export
print.cpue_result <- function(x, ...) {
  cat("CPUE Results for", length(x), " records\n")
  cat("Values: ", round(x, 2), "\n")
  invisible(x)
}
