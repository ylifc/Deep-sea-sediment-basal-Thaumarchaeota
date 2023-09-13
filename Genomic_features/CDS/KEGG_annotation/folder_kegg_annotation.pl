#!/usr/bin/perl -w
use warnings;
$kegg_m8_path="$ARGV[0]";
opendir DIR,$kegg_m8_path||die "can not open dir \"$DIR\"\n";
@filelist = readdir DIR;
foreach $file (@filelist) {
	if ($file =~ m/\.m8/) {
		print "perl ~/Desktop/Database_metawrap/KEGG/anotation.v2.pl ~/Desktop/Database_metawrap/KEGG/all_annotation.txt $file $file\.m8out1 $file\.m8out2\n";
	}
}
close DIR;


