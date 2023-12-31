% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prep_dendro.r
\name{prep_dendro}
\alias{prep_dendro}
\title{Prepare dendrogram}
\usage{
prep_dendro(ctdIN, expand = c(0, 0.66))
}
\arguments{
\item{ctdIN}{A single annotLevel of a ctd, i.e. ctd[[1]] (the function is
intended to be used via apply).}
}
\value{
A CellTypeDataset with dendrogram plotting info added.
}
\description{
\code{prep_dendro} adds a dendrogram to a CellTypeDataset (CTD).
}
\keyword{internal}
