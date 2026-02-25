#' Calculate Catch per unit effort (CPUE)
#'
#' Calculate Catch per unit effort (CPUE) as catch divided by effort, optionally adjusting for gear standardization.
#'
#' @param catch Numeric vector of catch
#' @param effort Numeric vector of effort
#' @param gear_factor Numeric adjustment for gear standardize
#' @param verbose Logical value to show messages (default is FALSE, use fishr.verbose option to set globally)
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
  verbose = getOption("fishr.verbose", default = FALSE)
) {
  if (verbose) {
    message("Processing ", length(catch), " records")
  }
  raw_cpue <- catch / effort
  raw_cpue * gear_factor
}
