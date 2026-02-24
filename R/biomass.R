
#' Calculate biomass index
#'
#' Calculation of biomass index from the CPUE and area swept
#'
#' @param cpue Numeric vector of CPUE values
#' @param area_swept Numeric vector of area sweph (e.g., km^2)
#'
#' @returns A numeric vector of the biomass index
#' @export
#'
#' @examples
#' salmon_cpue <- cpue(10, 2)
#' area_swept <- 10
#' biomass_index(salmon_cpue, area_swept)
biomass_index <- function(cpue, area_swept) {
  cpue / area_swept
}
