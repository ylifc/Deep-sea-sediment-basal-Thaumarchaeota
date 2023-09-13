#!/usr/bin/perl -w
use warnings;
open IN, "<$ARGV[0]";
$phy_path = "$ARGV[1]";
$phy_path =~ s/\/$//;
opendir DIR, $phy_path||die "can not open \"$DIR\"";
@filelist = readdir DIR;
open OU, ">rename.sh";
while ($line=<IN>) {
	$ori=(split /\s+/,$line)[0];
	$cha=(split /\s+/,$line)[1];
	foreach $file (@filelist) {
		if ($file =~ m/\.phylip/) {
			print OU "sed -i 's/$ori/$cha/' $file\n";
}
}
}
close OU;
close IN;
system("sh rename.sh");
