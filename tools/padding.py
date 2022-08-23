#!/bin/env python3
import sys

# arguments are: source, desiredSize, byte to pad with
fileName = str(sys.argv[1])
destSize = int(sys.argv[2])
sys.argv.append("00")
padByte = bytes.fromhex(str(sys.argv[3]))

rom = open(fileName, "ab")

beforeSize = len(open(fileName, "rb").read())
padSize = (destSize - beforeSize)

print("Needs to be " + str(destSize) + " bytes.")
print("Padding " + str(padSize) + " byte(s) with 0x" + str(sys.argv[3]) + "...", end=" ")
pad = padByte * padSize

rom.write(pad)

rom.close()

print("Done!")
