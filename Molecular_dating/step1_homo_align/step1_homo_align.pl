#!/usr/bin/perl -w
use warnings;
$cds_path="$ARGV[0]";
$homo_path="$ARGV[1]";#absolute path to homo file
open OU, ">sh_diamond.sh";
$cds_path=~s/\/$//;
opendir DIR, $cds_path|| die "can not open dir \"$DIR\"\n";
@filelist = readdir DIR;
foreach $file (@filelist) {
        if ($file =~ m/\.fa/) {
		$file_re=$file;
                $file_re=~s/\.fa//;
		$homo_path2= $homo_path;
		print OU "diamond blastx --db $homo_path2 --query $cds_path\/$file --out $file_re\.m8 --max-target-seqs 1 --threads 64 --query-cover 85 --evalue 0.000001 --min-score 80 --very-sensitive\n";
	}
}
close OU;
close DIR;
system("sh sh_diamond.sh");
system("mkdir homo_m8");
system("mv *.m8 homo_m8");
system("rm -rf *.sh");
