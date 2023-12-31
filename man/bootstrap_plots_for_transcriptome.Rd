% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootstrap_plots_for_transcriptome.R
\name{bootstrap_plots_for_transcriptome}
\alias{bootstrap_plots_for_transcriptome}
\title{Bootstrap plot}
\usage{
bootstrap_plots_for_transcriptome(
  dat,
  tag,
  listFileName,
  cc,
  showGNameThresh,
  graph_theme,
  maxX,
  save_dir = file.path(tempdir(), paste0("BootstrapPlots", "_for_transcriptome")),
  height = 3.5,
  width = 3.5,
  show_plot = TRUE
)
}
\value{
Null result.
}
\description{
Plot results of \link[EWCE]{generate_bootstrap_plots_for_transcriptome}.
}
\keyword{internal}
