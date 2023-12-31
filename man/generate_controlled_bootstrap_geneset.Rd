% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_controlled_bootstrap_geneset.r
\name{generate_controlled_bootstrap_geneset}
\alias{generate_controlled_bootstrap_geneset}
\title{generate_controlled_bootstrap_geneset}
\usage{
generate_controlled_bootstrap_geneset(
  hits,
  sct_data,
  annotLevel,
  reps,
  controlledCT = FALSE,
  verbose = TRUE
)
}
\arguments{
\item{hits}{List of gene symbols containing the target gene list.
Will automatically be converted to human gene symbols
if \code{geneSizeControl=TRUE}.}

\item{sct_data}{List generated using \link[EWCE]{generate_celltype_data}.}

\item{annotLevel}{An integer indicating which level of \code{sct_data} to
analyse (\emph{Default: 1}).}

\item{reps}{Number of random gene lists to generate (\emph{Default: 100},
but should be >=10,000 for publication-quality results).}

\item{controlledCT}{[Optional] If not NULL, and instead is the name of a
cell type, then the bootstrapping controls for expression within that
cell type.}

\item{verbose}{Print messages.}
}
\value{
Matrix of genes
 (such that \code{nrows=length(hits)} and \code{ncols=reps}), where each
column is a gene list.
}
\description{
Used to generated cell type-controlled bootstrapped gene sets.
}
\details{
See \link[EWCE]{controlled_geneset_enrichment} for examples.
}
\keyword{internal}
