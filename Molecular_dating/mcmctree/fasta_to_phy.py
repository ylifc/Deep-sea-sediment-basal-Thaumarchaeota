import sys
file = open(sys.argv[1],"r")
out = open(sys.argv[2],"w")
for line in file:
    line = line.strip()
    if line.startswith(">"):
        out.write(line[1:] + "\t")
    else:
        out.write(line + "\n")       
file.close()
out.close()
