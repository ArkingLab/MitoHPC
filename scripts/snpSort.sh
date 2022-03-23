#!/usr/bin/env bash
set -e

##############################################################################################################

# Program that sorts SNVs

##############################################################################################################

if [ "$#" -lt 1 ]; then exit 0 ; fi

test -s $1.vcf
cat $1.vcf | grep "^#" | grep -v "^##bcftools_annotate" > $1.srt.vcf 
cat $1.vcf | grep -v "^#" | sort -k1,1 -k2,2n -k4,4 -k5,5 >> $1.srt.vcf
mv  $1.srt.vcf $1.vcf

