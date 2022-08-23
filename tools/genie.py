#!/bin/env python3
import json

def parse_values(code):
    map = {"a":0x0,"p":0x1,"z":0x2,"l":0x3,"g":0x4,"i":0x5,"t":0x6,"y":0x7,"e":0x8,"o":0x9,"x":0xa,"u":0xb,"k":0xc,"s":0xd,"v":0xe,"n":0xf}
    code = code.lower()
    n0 = map[code[0]]
    n1 = map[code[1]]
    n2 = map[code[2]]
    n3 = map[code[3]]
    n4 = map[code[4]]
    n5 = map[code[5]]

    address = 16 + ((n3 & 7) << 12) | ((n5 & 7) << 8) | ((n4 & 8) << 8) | ((n2 & 7) << 4) | ((n1 & 8) << 4) | (n4 & 7) | (n3 & 8)
    data = ((n1 & 7) << 4) | ((n0 & 8) << 4) | (n0 & 7) | (n5 & 8)

    return (address, data)

print("Checking for Game Genie codes...")
codes = json.loads(open("ggcodes.json", "r").read()) # You can put Game Genie codes in comma-separated strings inside those brackets in ggcodes.json
if len(codes) == 0:
	print("No codes found. Done!")
else:
	patches = []
	print("Found " + str(len(codes)) + " cheat(s)! Patching...")
	for code in codes:
		patch = parse_values(code)
		if patch == None:
			continue
		if patch[0] > (32768 + 8192): # Not in code range
			print("{}: {} isn't in range".format(hex(patch[0] + 0x8000), hex(patch[1])))
			continue
		patches.append(patch)
	with open("smb.nes", "rb") as file:
		buf = bytearray(file.read())
	for patch in patches:
		buf[patch[0] + 16] = patch[1]
		print("Patched {}: {}".format(hex(patch[0] + 0x8000), hex(patch[1])))
	with open("smb.nes", "wb") as file:
		file.write(buf)
	print("Done!")
