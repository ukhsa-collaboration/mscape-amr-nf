#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include {ABRICATE} from "../modules/abricate"


workflow AMR_ANALYSIS {
    take:
    single_end

    main:
    // 1 - Run Abricate
    // Abricate can use fastq.gz, so just point to files.
    single_end.view()
    ABRICATE(single_end)
    // SCAGAIRE(ABRICATE.out.abricate_out)
}