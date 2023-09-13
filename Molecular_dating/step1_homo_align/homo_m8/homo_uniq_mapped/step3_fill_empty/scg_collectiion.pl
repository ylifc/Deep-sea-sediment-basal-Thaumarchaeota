#!/usr/bin/perl -w
use warnings;
#Usage: 
#perl scgs_to_cfg.pl <dir_name>

($bin_dir) = @ARGV;

#making scg list
system("ls $bin_dir > scg_list.txt");
system("cat $bin_dir/*.fa* > cat.tmp");

#extract species
open IN, "./cat.tmp";
open OU, ">./species_tmp";
while(<IN>){
   chomp;
       if(m/>/){
           s/>//;
               my$ID = $_;
                   print OU "$ID\n";
                       }
                       }
                       close OU;
                       close IN;
                       unlink './cat.tmp';

                       #unify species
                       open IN, "./species_tmp";
                       my%hash = ();
                       while(<IN>){
                           chomp;
                               $hash{$_} = 1;
                               }
                               foreach $_(keys %hash)
                               {
                                   system("echo \">$_\" >> $_\.fa.tmp");
                                   }
                                   close IN;
                                   unlink './species_tmp';

                                   #making scg and merged fa
                                   $a = 1;
                                   $gene = 1;
                                   $sum_len = 0;
                                   $len=();
                                   open IN2, "./scg_list.txt";
                                   open OU2, ">./cfg.txt";
                                   while(<IN2>){
                                       open II, "$bin_dir/$_";
                                           while(<II>){
                                                   chomp;
                                                           s/>//;
                                                                   if(exists $hash{$_}){
                                                                               $species = $_;
                                                                                           $seq = <II>;
                                                                                                       chomp ($seq);
                                                                                                                   $len = length($seq);
                                                                                                                               system("echo \"$seq\" >> $species\.fa.tmp");
                                                                                                                                       }
                                                                                                                                           }
                                                                                                                                               $sum_len = $sum_len + $len;
                                                                                                                                                   print OU2 "    charset part$gene = $a\-$sum_len;\n";
                                                                                                                                                       $a = $a + $len;
                                                                                                                                                           $gene++;
                                                                                                                                                           }
                                                                                                                                                           close IN2;
                                                                                                                                                           close OU2;

                                                                                                                                                           #merge fa files
                                                                                                                                                           system("cat ./*.fa.tmp > merged.fa");
                                                                                                                                                           system("rm ./*.tmp");
                                                                                                                                                           system("rm ./scg_list.txt");

                                                                                                                                                           #reformate fa file
                                                                                                                                                           open IN, "merged.fa";
                                                                                                                                                           open OU1, ">./tem.reformated";
                                                                                                                                                           while(<IN>){
                                                                                                                                                               s/\r//g;
                                                                                                                                                                   chomp;
                                                                                                                                                                       if(m/>/){
                                                                                                                                                                           s/>//;
                                                                                                                                                                               my$ID = (split /\s+/,$_)[0];
                                                                                                                                                                                   print OU1 ">$ID";
                                                                                                                                                                                       print OU1 "cjwfengecjw\n";
                                                                                                                                                                                           }else{
                                                                                                                                                                                               s/ //g;
                                                                                                                                                                                                   print OU1 "$_\n";
                                                                                                                                                                                                       }
                                                                                                                                                                                                       }
                                                                                                                                                                                                       close IN;
                                                                                                                                                                                                       close OU1;

                                                                                                                                                                                                       open IN, "./tem.reformated";
                                                                                                                                                                                                       open OU2, ">./reformated_merged.fa";
                                                                                                                                                                                                       $/=">";<IN>;
                                                                                                                                                                                                       while (<IN>) {
                                                                                                                                                                                                           chomp;
                                                                                                                                                                                                               s/\n//g;
                                                                                                                                                                                                                   $id=(split /cjwfengecjw/,$_)[0];
                                                                                                                                                                                                                       $seq=(split /cjwfengecjw/,$_)[1]; #<------adjust to get seq
                                                                                                                                                                                                                           print OU2 ">$id\n$seq\n";
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           unlink './tem.reformated';
                                                                                                                                                                                                                           unlink './merged.fa';
                                                                                                                                                                                                                           close IN;

