include { get_genomes } from './get_genomes'
include { conservation } from './conservation'



workflow {
    // get_genomes()
    conservation()
}

// process get_phyla {

//     publishDir 'phylogenies'
//     // mode: 'copy'

//     input:
//         path input_file

//     output:
//         path "UPPER-${input_file}"

//     script:
//     """
//     python 01-get_phyla.py
//     """
// }


