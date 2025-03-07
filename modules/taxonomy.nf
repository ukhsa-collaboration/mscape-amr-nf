#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process READ_EXTRACT{
    tag "${climb_id}"
    container 'community.wave.seqera.io/library/pip_argparse_pandas_pathlib:2f69bdc5b6cf9eae' // Not sure if this works

    // 1. Extract Read IDs from Abricate output file
    input:
    tuple val(climb_id), path(taxon_report_dir), path(abricate_out)

    output:
    tuple val(climb_id)

    script:
    """
    echo $climb_id
    echo $taxon_report_dir
    echo $abricate_out
    tail -n +2 abricate_out.txt | cut -f2 | sort | uniq >read_ids.txt
    while read i; do \
        grep -P '\${i}\t' \
        ${taxon_report_dir}/${climb_id}_C-514753DBDA_PlusPF.kraken_assignments.tsv \
        | cut -f 2-3 >>kraken_assignment.tsv; \
    done<read_ids.txt

    retrieve_taxon.py \
        -t kraken_assignment.tsv \
        -j ${taxon_report_dir}/${climb_id}_PlusPF.kraken_report.json \
        -o reads_kraken_taxa.tsv    

    """
}
