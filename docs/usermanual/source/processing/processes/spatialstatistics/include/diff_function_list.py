# diff_function_list.py
#
# generates a ReStructured Text list of spatial-statistics process named "function_list_ss.txt"
# The geotools docs jar and the spatial statistics jars should be 
# available in your local maven repository.

import subprocess

# geotools processes
process = subprocess.call(["bash", "-c", "mvn exec:exec -q > function_list_gt.txt"])

# geotools + spatial statistics processes
process = subprocess.call(["bash", "-c", "mvn exec:exec -q -Pspatial-statistics > function_list_all.txt"])

gtHeadings = []

fin = open("function_list_gt.txt", "r")

lastLine = ""

# iterate through function_list_gt.txt and get the name of each geotools function
for line in fin:
    # remove trailing newline
    line = line.strip()
    # is this a section underline? If so, lastLine is the name of a function
    if (line.count("'") == len(line) and len(line) == len(lastLine)):
        gtHeadings.append(lastLine)
    lastLine = line

fin.close();

fin = open("function_list_all.txt", "r")

fout = open("function_list_ss.txt", "w")

lastLine = ""
write = False

# iterate through function_list_all.txt, and write all function descriptions 
# not in function_list_gt.txt to function_list_ss.txt
for line in fin:
    line = line.strip()
    #is this a section underline? If so, lastLine is the name of a function
    if (line.count("'") == len(line) and len(line) == len(lastLine)):
        # if the function name is a geotools function, don't write anything 
        # until we reach the next section underline
        if (lastLine in gtHeadings):
            write = False
        else:
            write = True
    if (write):
        fout.write(lastLine)
        fout.write("\n")
    lastLine = line

if (write):
    fout.write(lastLine)

fin.close
fout.close


