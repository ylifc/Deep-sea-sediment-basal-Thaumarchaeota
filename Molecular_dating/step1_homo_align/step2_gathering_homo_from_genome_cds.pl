#!/usr/bin/perl -w
$cds_homo_blsated_dir = "$ARGV[1]"; #cds after blsat against homo database, the dir save the m8 files
$cds_dir = "$ARGV[2]";#the dir saves the cds files
$cds_dir =~ s/\/$//;
$cds_homo_blsated_dir =~ s/\/$//;
opendir DIR, $cds_homo_blsated_dir|| die "can not open dir \"$DIR\"\n";
@filelist = readdir DIR;
%hash=();
%hash2=();
open IN, "<$ARGV[0]"; #homo_list;
while ($homo=<IN>) {
	chomp $homo;
	$hash{$homo}=1;
	%hash=();
	%hash2=();
foreach $file (@filelist) {
			if ($file =~ m/\.m8/) {
				open IN2, "<$file";
				while ($blast_result=<IN2>) {
					chomp $blast_result;
					$homo2= (split /\s+/,$blast_result)[1];
					#print "$homo2\n";
					$contig=(split /\s+/,$blast_result)[0];
					# print "$contig\n";
					if ($homo=~m/$homo2/) {
						print "$homo2\n";
						#	 print "$contig\n";
						$hash2{$contig}=$homo2;

					}
				}
			}
		}
		close IN2;
		open OU, ">$homo\_mapped\.fa";
	foreach $contig_in_genomes (keys %hash2) {
		$file_name = $contig_in_genomes;
		$file_name =~s/-contig.*/_renamed_cds\.fa/;
		$file_name =~s/_contig.*/_renamed_cds\.fa/;
		open IN3, "<$cds_dir\/$file_name";
		print "open $cds_dir\/$file_name\n";
		while ($line = <IN3>) {
			chomp $line;
			if ($line =~ m/^>/) {
				$line1 = (split /\s+/,$line)[0];
				$line1 =~s/>//;
				$i=0;
				if ($hash2{$line1}) {
					$clean_genome_name = $file_name;
					$clean_genome_name =~ s/_renamed_cds\.fa//;
					$clean_genome_name =~ s/_reformat//;
					print OU ">$clean_genome_name\n";
					$i=1;
				} else {
					if ($i==1) {
						print OU "$line\n";
					}
				}
			}
		}
	}
close OU;
}
close IN;
close DIR;

