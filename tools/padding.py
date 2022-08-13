#!/bin/env python3

rom = open("smb.nes", "ab")
byte = b"\xff"

beforeSize = len(open("smb.nes", "rb").read())
padSize = (40976 - beforeSize)

print("Padding " + str(padSize) + " byte(s)...", end=" ")
pad = byte * padSize

rom.write(pad)

rom.close()

print("Done!")
