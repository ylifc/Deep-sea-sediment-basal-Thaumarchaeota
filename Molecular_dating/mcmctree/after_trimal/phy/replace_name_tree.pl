#!/usr/bin/perl -w
use warnings;
open IN, "<$ARGV[0]";
open OU, ">rename.sh";
while ($line=<IN>) {
        $ori=(split /\s+/,$line)[0];
        $cha=(split /\s+/,$line)[1];
                        print OU "sed -i 's/$ori/$cha/' phylogenomic_tree.tree\n";
}
close OU;
close IN;
system("sh rename.sh");
