#!/usr/bin/perl -w
use List::Util qw(reduce);
use List::Util::XS;

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
	%hash=();
	%hash2=();
	chomp $homo;
	$hash{$homo}=1;
foreach $file (@filelist) {
			if ($file =~ m/\.m8/) {
				open IN2, "<$file";
				while ($blast_result=<IN2>) {
					chomp $blast_result;
					$homo2= (split /\s+/,$blast_result)[1];
					$contig=(split /\s+/,$blast_result)[0];
					# print "$contig\n";
					if ($hash{$homo2}) {
						$hash2{$contig}=$homo2;
					}
				}
			}
		}
		open OU, ">$homo\_mapped\.fa";
	foreach $contig_in_genomes (keys %hash2) {
		$file_name = $contig_in_genomes;
		$file_name =~s/-contig.*/_renamed_cds\.fa/;
		$file_name =~s/_contig.*/_renamed_cds\.fa/;
		open IN3, "$cds_dir\/$file_name" or die "Can't open '$cds_dir\/$file_name': $!";
		#print "open $cds_dir\/$file_name\n";
		while ($line = <IN3>) {
			chomp $line;
			if ($line =~ m/^>/) {
				$line1 = (split /\s+/,$line)[0];
				$line1 =~s/>//;
				#print "$line1\n";
				$i=0;
				if ($hash2{$line1}) {
					#	$clean_genome_name = $file_name;
					#$clean_genome_name =~ s/_renamed_cds\.fa//;
					#$clean_genome_name =~ s/_reformat//;
					#	print "$line1\n";
					print OU ">$line1\n";
					$i=1;
				} }else {
					if ($i==1) {
						print OU "$line\n";
					}
				}
			}
		}
close OU;
}
close IN;
close DIR;
system("perl /home/ylifc/Desktop/script/fasta_reformat_two_lines.pl $cds_homo_blsated_dir");
%hash3=();
%hash4=();
$homo_mapped_path=$cds_homo_blsated_dir;
opendir DIR2, $homo_mapped_path|| die "can not open dir \"$DIR2\"\n";
@filelist_homo = readdir DIR2;
foreach $file_homo(@filelist_homo) {
		if ($file_homo=~m/_mapped_reformat.fa/) {
		open IN4, "<$file_homo";
		%hash3=();
		%hash4=();
		while ($line_homo = <IN4>) {
				chomp $line_homo;
				if ($line_homo=~ m/>/) {
					$contig_name=$line_homo;
					$contig_name=~s/_contig.*//;
					$contig_name=~s/-contig.*//;
					$hash3{$contig_name}=1;
				} else {
					$seq=$line_homo;
					push (@{$contig_name},($seq));
				}
			}
			close IN4;
			$file_homo=~s/_mapped_reformat.fa//;
			open UH, ">$file_homo\_uniq.fa";
	foreach $c_n (keys %hash3) {
			$seq=$hash3{$c_n};
			$c_n=~s/-contig.*//;
			$c_n=~s/_contig.*//;
			$max_length = reduce{ length($a) > length($b) ? $a : $b } @{$c_n};
		print UH "$c_n\n$max_length\n";
	}
	close UH;
}
}
close DIR2;
system("rm -r *_mapped_reformat.fa *_mapped.fa");
system("mkdir homo_uniq_mapped");
system("mv *_uniq.fa homo_uniq_mapped/");	
