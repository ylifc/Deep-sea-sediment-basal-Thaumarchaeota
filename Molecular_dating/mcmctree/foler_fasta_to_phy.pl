#!/usr/bin/perl -w
use warnings;
$hmm_pre_will_path="$ARGV[0]";
opendir DIR,$hmm_pre_will_path||die "can not open dir \"$DIR\"\n";
@filelist = readdir DIR;
foreach $file (@filelist) {
	if ($file =~ m/.fa/) {
		$file_phy = $file;
		$file_phy =~ s/\.fa/\.phy/;
		system("python /home/ylifc/Desktop/script/fasta_to_phy.py $file $file_phy");
	}
}
close DIR;
