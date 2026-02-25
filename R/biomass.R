#' Calculate biomass index
#'
#' Calculation of biomass index from the CPUE and area swept
#'
#' @param cpue Numeric vector of CPUE values
#' @param area_swept Numeric vector of area swept (e.g., km^2)
#' @param catch Numeric
#' @param effort Numeric
#' @param ... arguments passed to CPUE
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
  ...
) {
  if (is.null(cpue) && !is.null(catch) && !is.null(effort)) {
    cpue <- cpue(catch, effort, ...)
  }
  cpue / area_swept
}
