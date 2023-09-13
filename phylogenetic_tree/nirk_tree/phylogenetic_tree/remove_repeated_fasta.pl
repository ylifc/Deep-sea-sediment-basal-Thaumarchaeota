#!/usr/bin/perl -w
use warnings;
%hash=();
open IN, "$ARGV[1]";
while ($line=<IN>) {
	chomp $line;
        if ($line=~m/^>/) {
                                $i=0;
				$hash{$line}+=1;
                                $i=0;
				 if ($hash{$line}>1) {
                                        $i=0;
                                } else {
                               print "$line\n";
			       		$i=1;
                                }
			} else {
				if ($i==1) {
					print "$line\n";
                        }
		}
	}
	close IN;

