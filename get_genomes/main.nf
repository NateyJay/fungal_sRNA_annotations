

process get_genome_list {
    publishDir 'get_genomes'
    master_table = file("/Volumes/YASMA/master_table.xlsx")
    
    output:
        path "01out-genome_summary.tsv"
        // path "01out-selected_genomes.xlsx"

    script:
    """
    01-get_genome_list.py
    """
}


process download {
    publishDir 'get_genomes'

    input:
        path "01out-selected_genomes.xlsx"

    output:
        path "+genomes/*.fa"

    script:
    """
    02-download.py
    """
}


workflow get_genomes {
    get_genome_list()
    // get_genome_list.out.view()
    download(get_genome_list.out)

}

