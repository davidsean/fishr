#' Calculate Catch per unit effort (CPUE)
#'
#' Calculate Catch per unit effort (CPUE) as catch divided by effort, optionally adjusting for gear standardization.
#'
#' @param catch Numeric vector of catch
#' @param ... Additional arguments passed on to methods
#' @export
cpue <- function(catch, ...) {
  UseMethod("cpue")
}

#' @rdname cpue
#'
#' @export
cpue.default <- function(catch, ...) {
  stop("No method available for class ", class(catch), call. = FALSE)
}

#' @rdname cpue
#'
#' @param catch Dataframe with columns 'catch' and 'effort' columns

#' @export
cpue.data.frame <- function(
  catch,
  gear_factor = 1,
  method = c("ratio", "log"),
  verbose = getOption("fishr.verbose", default = FALSE),
  ...
) {
  if (!"catch" %in% names(catch)) {
    stop("Column 'catch' not found in data frame.", call. = FALSE)
  }
  if (!"effort" %in% names(catch)) {
    stop("Column 'effort' not found in data frame.", call. = FALSE)
  }
  cpue(
    catch = catch$catch,
    effort = catch$effort,
    gear_factor = gear_factor,
    method = method,
    verbose = verbose
  )
}


#' @rdname cpue
#' @param effort Numeric vector of effort
#' @param gear_factor Numeric adjustment for gear standardize
#' @param verbose Logical value to show messages (default is FALSE, use fishr.verbose option to set globally)
#' @param method
#'
#' @returns a numeric, vector of CPUE values of the class `cpue_result`
#' @export
#'
#' @examples
#' cpue(100,10)
#' cpue(100, 10, gear_factor=0.5)
cpue.numeric <- function(
  catch,
  effort,
  gear_factor = 1,
  method = c("ratio", "log"),
  verbose = getOption("fishr.verbose", default = FALSE),
  ...
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
  result <- new_cpue_result(
    result,
    method = method,
    gear_factor = gear_factor,
    n_records = length(catch)
  )
  return(result)
}

#' @export
print.cpue_result <- function(x, ...) {
  cat("CPUE Results\n")
  cat("Num records: ", attr(x, "n_records"), "\n")
  cat("Gear factor: ", attr(x, "gear_factor"), "\n")
  cat("Method: ", attr(x, "method"), "\n")
  cat("Values: ", round(x, 2), "\n")
  invisible(x)
}

#' @export
summary.cpue_result <- function(object, ...) {
  cat("CPUE Results\n")
  cat("Num records:\t", attr(object, "n_records"), "\n")
  cat("Gear factor:\t", attr(object, "gear_factor"), "\n")
  cat("Method:\t", attr(object, "method"), "\n")
  cat("Values:\t", round(object, 2), "\n")
  cat("Mean CPUE:\t", round(mean(object), 2), "\n")
  cat("Median CPUE:\t", round(stats::median(object), 2), "\n")
  cat("SD CPUE:\t", round(stats::sd(object), 2), "\n")
  invisible(object)
}


#' @export
plot.cpue_result <- function(x, ...) {
  method <- attr(x, "method")
  gear_factor <- attr(x, "gear_factor")
  plot_args <- list(...)
  vals <- as.numeric(unclass(x))

  # vals will be plotted as the x-axis
  plot_args["x"] <- list(vals)

  if (length(gear_factor) == 1) {
    gear_factor_str <- paste("gear_factor:", gear_factor)
  } else {
    gear_factor_str <- "multiple gear factors"
  }

  ## setup the plot with user or default options

  # define default y-label if not given from from elipses
  if (!"ylab" %in% names(plot_args)) {
    plot_args["ylab"] <- "CPUE"
  }

  # define default x-label if not given from from elipses
  if (!"xlab" %in% names(plot_args)) {
    plot_args["xlab"] <- "Record"
  }

  # define default type if not given from from elipses
  if (!"type" %in% names(plot_args)) {
    plot_args["type"] <- "b"
  }

  switch(
    method,
    ratio = {
      # define sub title if not given from from elipses
      if (!"sub" %in% names(plot_args)) {
        plot_args["sub"] <- paste("linear-scale with", gear_factor_str)
      }
    },
    log = {
      # define sub title if not given from from elipses
      if (!"sub" %in% names(plot_args)) {
        plot_args["sub"] <- paste("log-scale with", gear_factor_str)
      }
      # define log scale on y if not given from from elipses
      if (!"log" %in% names(plot_args)) {
        plot_args["log"] <- "y"
      }
    }
  )
  # call plot with modded params
  do.call(plot, plot_args)
  invisible(x)
}

#' Constructor for the cpue_result class
#'
#' @noRd
new_cpue_result <- function(values, method, gear_factor, n_records) {
  result <- structure(
    values,
    method = method,
    gear_factor = gear_factor,
    n_records = n_records
  )
  class(result) <- "cpue_result"
  return(result)
}
