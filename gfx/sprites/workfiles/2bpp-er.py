#!/bin/env python3
import sys
from PIL import Image
import numpy as np

args = sys.argv # args are: source destination bits-per-pixel
#print(args)

"""
ok so

every 16 bytes make up an 8x8 tile

for each line of each tile:
8 bytes determine  first bit of color (if lightgrey or black)
8 bytes determine second bit of color (if darkgrey or black)

"""


#            00    01    10    11
palette = [ 239,  165,  107,    0]
bits    = [0b00, 0b01, 0b10, 0b11]

img = Image.open('test1.png').convert('L')
image = np.array(img)
#print(image)

b1output = []
b2output = []

for line in image:
	outputLine = ""
	for pixel in range(len(line)):
		color = palette.index(line[pixel])
		if color % 2 == 1:
			outputLine += "1"
		else:
			outputLine += "0"
	b1output.append(hex(eval("0b"+outputLine[0:4])))
	b1output.append(hex(eval("0b"+outputLine[4:])))

for line in image:
	outputLine = ""
	for pixel in range(len(line)):
		color = palette.index(line[pixel])
		if color >= 2:
			outputLine += "1"
		else:
			outputLine += "0"
	b2output.append(hex(eval("0b"+outputLine[0:4])))
	b2output.append(hex(eval("0b"+outputLine[4:])))

print(b1output)
print(b2output)

print(hex(eval("0b"+"0000")))


out = open("out.bin", "ab")
out.truncate(0)

for i in range(int(len(b1output)/2)):
	hexOut = b1output[i*2][2] + b1output[i*2+1][2]
	print(bytes.fromhex(hexOut))
	out.write(bytes.fromhex(hexOut))
for i in range(int(len(b2output)/2)):
	hexOut = b2output[i*2][2] + b2output[i*2+1][2]
	out.write(bytes.fromhex(hexOut))

out.close()

