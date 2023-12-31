#' Convert a CellTypeDataset into standardized format
#'
#' This function will take a CTD,
#' drop all genes without 1:1 orthologs with the
#' \code{output_species} ("human" by default),
#' convert the remaining genes to gene symbols,
#' assign names to each level,
#' and convert all matrices to sparse matrices and/or \code{DelayedArray}.
#'
#' @param ctd Input CellTypeData.
#' @param dataset CellTypeData. name.
#' @param force_new_quantiles By default, quantile computation is
#' skipped if they have already been computed.
#' Set \code{=TRUE} to override this and generate new quantiles.
#' @param force_standardise If \code{ctd} has already been standardised, whether
#' to rerun standardisation anyway (Default: \code{FALSE}).
#' @param remove_unlabeled_clusters Remove any samples that have
#'  numeric column names.
#' @param numberOfBins Number of non-zero quantile bins.
#' @param keep_annot Keep the column annotation data if provided.
#' @param keep_plots Keep the dendrograms if provided.
#' @param verbose Print messages.
#' Set \code{verbose=2} if you want to print all messages
#'  from internal functions as well.
#' @inheritParams extract_matrix
#' @inheritParams drop_uninformative_genes
#' @inheritParams bootstrap_enrichment_test
#' @inheritParams orthogene::convert_orthologs
#' @inheritDotParams orthogene::convert_orthologs
#'
#' @return Standardised CellTypeDataset.
#'
#' @examples
#' ctd <- ewceData::ctd()
#' ctd_std <- EWCE::standardise_ctd(
#'     ctd = ctd,
#'     input_species = "mouse",
#'     dataset = "Zeisel2016"
#' )
#' @export
#' @importFrom utils packageVersion
standardise_ctd <- function(ctd,
                            dataset,
                            input_species = NULL,
                            output_species = "human",
                            sctSpecies_origin = input_species,
                            non121_strategy = "drop_both_species",
                            method = "homologene",
                            force_new_quantiles = TRUE,
                            force_standardise = FALSE,
                            remove_unlabeled_clusters = FALSE,
                            numberOfBins = 40,
                            keep_annot = TRUE,
                            keep_plots = TRUE,
                            as_sparse = TRUE,
                            as_DelayedArray = FALSE,
                            rename_columns = TRUE,
                            make_columns_unique = FALSE,
                            verbose = TRUE,
                            ...) {

    if (is_ctd_standardised(ctd = ctd) && 
        isFALSE(force_standardise)) {
        messager("ctd is already standardised. Returning original ctd.\n",
            "Set force_standardise=TRUE to re-standardise.",
            v = verbose
        )
        return(ctd)
    }
    #### Check species args ####
    species <- check_species(
        genelistSpecies = input_species,
        sctSpecies = output_species,
        sctSpecies_origin = sctSpecies_origin,
        sctSpecies_origin_default = NULL,
        verbose = verbose
    )
    input_species <- species$genelistSpecies
    output_species <- species$sctSpecies 
    sctSpecies_origin <- species$sctSpecies_origin 
    messager("Standardising CellTypeDataset", v = verbose)
    #### Check existing matrices ####
    matrices <- get_ctd_matrix_names(ctd = ctd,
                                     verbose = verbose)
    ## Require specificity_quantiles to be one of them 
    matrices <- unique(c(matrices,"specificity_quantiles"))
    #### Iterate over CTD levels ####
    new_ctd <- lapply(seq_len(length(ctd)), 
                      function(lvl) {
        messager("Processing level:", lvl, v = verbose) 
        return_list <- list()                  
        for(m in matrices){
            return_list[[m]] <- extract_matrix(
                ctd = ctd,
                input_species = input_species,
                output_species = output_species,
                dataset = dataset,
                level = lvl,
                metric = m,
                non121_strategy = non121_strategy,
                method = method,
                numberOfBins = numberOfBins,
                remove_unlabeled_clusters = remove_unlabeled_clusters,
                force_new_quantiles = force_new_quantiles,
                as_sparse = as_sparse,
                as_DelayedArray = as_DelayedArray,
                rename_columns = rename_columns,
                make_columns_unique = make_columns_unique,
                verbose = verbose,
                ...
            )
        }     
        #### Add extra items ####
        return_list[["annot"]] <- 
            if ("annot" %in% names(ctd[[lvl]]) & keep_annot) {
            ctd[[lvl]]$annot
        } else {
            ctd[[lvl]]$annot <- data.frame(
                annot=fix_celltype_names(colnames(ctd[[lvl]]$mean_exp))
            )
        }
        return_list[["plotting"]] <- 
            if ("plotting" %in% names(ctd[[lvl]]) & keep_plots) {
            ctd[[lvl]]$plotting
        } else {
            NULL
        }
        return_list[["standardised"]] <- TRUE
        return_list[["species"]] <- list(
            "input_species" = input_species,
            "output_species" = output_species,
            "sctSpecies_origin" = sctSpecies_origin)
        return_list[["versions"]] <- list(
            "EWCE" = utils::packageVersion("EWCE"),
            "orthogene" = utils::packageVersion("orthogene"),
            "homologene" = utils::packageVersion("homologene")
        )
        return(return_list)
    })
    #### Name CTD levels ####
    if (is.null(names(ctd))) {
        names(new_ctd) <- paste0("level_", seq_len(length(ctd)))
    } else {
        names(new_ctd) <- names(ctd)
    }
    return(new_ctd)
}
