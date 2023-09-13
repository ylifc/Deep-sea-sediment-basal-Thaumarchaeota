#!/usr/bin/perl -w
use warnings;
$empty_filled="$ARGV[0]";
$empty_filled=~s/\/$//;

opendir DIR_lyd, $empty_filled|| die "can not open dir \"$DIR_lyd\"\n";
@filelist_lyd = readdir DIR_lyd;
foreach $file_lyd (@filelist_lyd) {
                if ($file_lyd =~ m/_trimal\.fa/) {
                        open IN_lyd, "<$file_lyd";
                        $file_out_lyd_final = $file_lyd;
                        $file_out_lyd_final =~ s/_trimal.fa/_tri_ref.fa/;
                        open OUT_final, ">$file_out_lyd_final";
                        while ($llll=<IN_lyd>) {
                                chomp $llll;
                                if ($.==1) {
                                        print OUT_final "$llll\n";
                                } else {
                                        if ($llll=~m/^>/) {
                                                print OUT_final "\n$llll\n";
                                        } else {
                                                print OUT_final "$llll";
                                        }
                                }
                        }
                }
        }
        close DIR_lyd;
        close IN_lyd;
        close OUT_final;
system("mkdir after_trimal");
system("mv *_tri_ref.fa after_trimal")
