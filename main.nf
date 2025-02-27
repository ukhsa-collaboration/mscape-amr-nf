#!/usr/bin/env nextflow
// nextflow.enable.dsl=2

// TODO: add include to read in subworkflows
include { run_abricate } from './subworkflows/run_abricate'

if (!params.samplesheet) {
    error "Please provide a samplesheet with --samplesheet"
}

Channel
    .fromPath(params.samplesheet)
    .splitCsv(header: true)
    .map { row =>
        def climb_id = row.CLIMB-ID
        return value(climb_id)
    }
    .set { ch_samplesheet }

workflow {
    // handle input parameters
    log.info "Samplesheet: ${params.samplesheet}"
    log.info "Output directory: ${params.output}"
    log.info "Number of CPUs (Max): ${params.max_cpus}"
    // Run subworkflows
    // run_abricate(params.climb_id, params.output)

}