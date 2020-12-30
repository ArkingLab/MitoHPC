#!/bin/bash -eux

D=$1        # out dir

find $D/*/ -name "*.count" | xargs grep all    | perl -ane 'print "$1\t$2\n" if(/.+\/(\S+).count:(\d+)/);' | sort -u > $D/count.all.tab
find $D/*/ -name "*.count" | xargs grep mapped | perl -ane 'print "$1\t$2\n" if(/.+\/(\S+).count:(\d+)/);' | sort -u > $D/count.mapped.tab
find $D/*/ -name "*.count" | xargs grep chrM   | perl -ane 'print "$1\t$2\n" if(/.+\/(\S+).count:(\d+)/);' | sort -u > $D/count.chrM.tab
find $D/*/ -name "*.count" | xargs grep filter | perl -ane 'print "$1\t$2\n" if(/.+\/(\S+).count:(\d+)/);' | sort -u  > $D/count.filter.tab

join.pl $D/count.all.tab $D/count.mapped.tab | join.pl - $D/count.chrM.tab | join.pl - $D/count.filter.tab  | sort | egrep -v "mutect2|mutserve" | perl -ane 'BEGIN { print "Run\tall\tmapped\tchrM\tfilter\n" } print;' | getCN.pl > $D/count.tab
rm $D/count.*.tab
