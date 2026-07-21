
// supplementary table from https://doi.org/10.1016/j.cub.2021.01.074
params.input_table = "conservation/mmc2.csv"

// process DOWNLOAD_GENOMES(ch_data) {
    
    
//     input:
//       val data from ch_data

//     output:
//       stdout

//     script:
//     """
//     echo "source: ${data.source}, link: ${data.link}"
//     """
  
// }
process GENOME_SUMMARIES {
    
    output:
    path "assemblies.jsonl"

    script:
    """
    datasets summary genome taxon "fungi" --reference --as-json-lines > assemblies.jsonl
    """
}

process DOWNLOAD_GENOMES {

    
}

workflow conservation {


    GENOME_SUMMARIES()
    

}

