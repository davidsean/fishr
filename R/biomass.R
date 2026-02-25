#' Calculate biomass index
#'
#' Calculation of biomass index from the CPUE and area swept
#'
#' @param cpue Numeric vector of CPUE values
#' @param area_swept Numeric vector of area swept (e.g., km^2)
#' @param ... arguments passed to CPUE
#' @inheritParams cpue
#' @inheritDotParams cpue -catch -effort
#'
#' @returns A numeric vector of the biomass index
#' @export
#'
#' @examples
#' salmon_cpue <- cpue(10, 2)
#' area_swept <- 10
#' biomass_index(salmon_cpue, area_swept)
biomass_index <- function(
  cpue = NULL,
  area_swept,
  catch = NULL,
  effort = NULL,
  verbose = getOption("fishr.verbose", default = FALSE),
  ...
) {
  rlang::check_dots_used()

  if (verbose) {
    message("Processing ", length(area_swept), " area records")
  }

  if (is.null(cpue) && !is.null(catch) && !is.null(effort)) {
    cpue <- cpue(catch, effort, ...)
  }
  cpue / area_swept
}
