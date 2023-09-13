#!/usr/bin/perl -w
use warnings;
open IN, "<$ARGV[0]";
while ($line=<IN>) {
	$ori=(split /\s+/,$line)[0];
	$cha=(split /\s+/,$line)[1];
	print "sed -i 's/$ori/$cha/' fixed_tree2.tree\n";
}
close IN;
