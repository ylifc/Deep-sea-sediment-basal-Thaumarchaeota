#!/usr/bin/perl -w
use warnings;
open IN, "<$ARGV[0]";
while ($line=<IN>) {
	chomp $line;
	$gi=(split /\t/,$line)[0];
	$rep=(split /\t/,$line)[1];
	$num=(split /\s+/,$rep)[1];
	$hash{$gi}=$rep;
	$hash2{$gi}=$num;
}
close IN;
open II, "<$ARGV[1]";
while ($line2=<II>) {
	chomp $line2;
	if ($line2=~m/^>/) {
	$gi2=$line2;
	$i=0;
	$gi2=~s/>//;
	if ($hash2{$gi2}) {
		$i=1;
		print ">$hash{$gi2}\n";
	}
	}else { 
		if ($i==1) {
			print "$line2\n";
		}
	}
}
close II;

