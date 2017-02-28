"""
Simple program that takes runs with an input csv file, and outputs a longer file
based on it.

Takes arguments:
 -i inputfile.i

The input file should have five lines:
[outputParams]
 header line: names = "name name ...."
 start line: start = "start1 start2  ..."
 increment line: increment = "increment1 increment2 ..."
[]
and creates a csv file with 11 lines, the first is the header line names,
followed by start1 + i*increment1,start2 + i*increment2


"""


#for future compatibility with Python 3--------------------------------------------------------------
from __future__ import division, print_function, unicode_literals, absolute_import
import warnings
warnings.simplefilter('default',DeprecationWarning)
#End compatibility block for Python 3----------------------------------------------------------------

import sys,os

print("Arguments:",sys.argv)

if len(sys.argv) < 3 or sys.argv[1] != "-i":
  print(sys.argv[0]," -i input")
  sys.exit(-1)


inputFilename = sys.argv[2]
inputFile = open(inputFilename,"r")
root = os.path.splitext(inputFilename)[0]
head,tail = os.path.split(root)
outFile = open(os.path.join(head,"out~"+tail+".csv"),"w")

lines = inputFile.readlines()

def get_params(line):
  equalsIndex = line.index("=")
  name = line[:equalsIndex].strip()
  params = line[equalsIndex + 1:].strip().strip('"').split()
  return name,params

for name, params in [get_params(l) for l in lines[1:4]]:
  print(name,params)
  if name == "names":
    names = ",".join(params)
  elif name == "start":
    start = list(map(float, params))
  elif name == "increment":
    increment = list(map(float, params))

print(names,file=outFile)

for i in range(0,10):
  for j in range(0,min(len(start),len(increment))):
    if j != 0:
      print(end=",",file=outFile)
    print(start[j] + i*increment[j],end="",file=outFile)
  print(file=outFile)


outFile.close()