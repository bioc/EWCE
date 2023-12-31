% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_species.R
\name{check_species}
\alias{check_species}
\title{Check species}
\usage{
check_species(
  genelistSpecies = NULL,
  sctSpecies = NULL,
  sctSpecies_origin = NULL,
  sctSpecies_origin_default = "mouse",
  verbose = TRUE
)
}
\arguments{
\item{genelistSpecies}{Species that \code{hits} genes came from
(no longer limited to just "mouse" and "human").
See \link[EWCE]{list_species} for all available species.}

\item{sctSpecies}{Species that \code{sct_data} is currently formatted as
(no longer limited to just "mouse" and "human").
See \link[EWCE]{list_species} for all available species.}

\item{sctSpecies_origin}{Species that the \code{sct_data} 
originally came from, regardless of its current gene format 
(e.g. it was previously converted from mouse to human gene orthologs).
 This is used for computing an appropriate backgrund.}

\item{sctSpecies_origin_default}{Default value for \code{sctSpecies_origin}.}

\item{verbose}{Print messages.}
}
\value{
List of corrected species names.
}
\description{
If species arguments are \code{NULL}, set default species.
}
\keyword{internal}
