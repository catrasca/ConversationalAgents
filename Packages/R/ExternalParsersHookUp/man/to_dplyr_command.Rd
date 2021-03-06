% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Hook-up-for-spoken-dplyr.R
\name{to_dplyr_command}
\alias{to_dplyr_command}
\title{Interpret a dplyr spoken command.}
\usage{
to_dplyr_command(command, parse = TRUE)
}
\arguments{
\item{command}{A string with a command or a list of commands separated with ";".}

\item{parse}{A boolean should the result be parsed as an R expression.}
}
\value{
A string or an R expression
}
\description{
Calls Raku Perl 6 module function `to_dplyr` in order to get
interpretation of a spoken command or a list spoken commands separated with ";".
}
\details{
Produces a character vector or an expression depending on \code{parse}.
}
\seealso{
Other Spoken dplyr: \code{\link{DPLYRInterpret}},
  \code{\link{DPLYRParse}}
}
\concept{Spoken dplyr}
