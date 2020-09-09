for file in *.sam;do sample=${file%.sam}; samtools view -@ 7 -hbo $sample.bam $sample.sam; rm $sample.sam ; samtools sort -@ 7 $sample.bam -o $sample.sorted.bam ;done

### merging all bam files ##
stringtie --merge -p 8 *gtf -o merged.gtf
###then stringtie assembly one more time using merged as the reference file ##
for file in *bam; do sample=${file%.sorted.bam}; stringtie -p 8 -G GTF/merged.gtf $file -o $sample.guided.gtf -l $sample;done


#####Guided assembly ###
for file in *bam; do sample=${file%.sorted.bam}; stringtie -p 8 -G ../../Whole_genome/Oryza_sativa.IRGSP-1.0.44.gtf $file -o ref_guided/$sample.ref_guided.gtf -l $sample;done