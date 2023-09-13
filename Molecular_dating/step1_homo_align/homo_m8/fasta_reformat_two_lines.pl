$DIR_PATH="./";
opendir DIR, ${DIR_PATH}|| die "can not open dir \"$DIR_PATH\"\n";
@filelist = readdir DIR;
foreach $file (@filelist) {
        if ($file =~ m/\.fa/) {
                open IN, "<$file";
                $file=~s/\.fa//;
                open OU, ">$file\_reformat.fa";
                while ($line=<IN>) {
			chomp $line;
			if ($.==1) {
				if ($line=~m/^>/) {
					print OU "$line\n";
				}
			} else {
				 if ($line=~m/^>/) {
                                        print OU "\n$line\n";
                                } else {
					print OU "$line";
				}
			}
		}
		close OU;
		close IN;
	}
}
close DIR;

