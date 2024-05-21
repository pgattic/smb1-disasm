# Super Mario Bros. Disassembly

This is an attempt to organize and streamline the disassembly code for Super Mario Bros. This code should still build the same ROM as the original, but with code that is easier to read and work with. 

It builds the following ROM: 

- smb.nes `sha1: ea343f4e445a9050d4b4fbac2c77d0693b1d0922`

## Progress

So far, the assembly code and data (excluding CHR) is all in one big asm file. I have a few milestones that I am hoping to reach:

- [ ] Separate assembly files into smaller, more specific pieces
- [ ] Extract more binary data into separate files (level maps, tile maps, etc.)

## Setup

### Linux/Mac/WSL

Make sure you have the following packages installed:

- `make`
- `gcc`
- `git`

Clone the repository and build the rom:

- `git clone https://github.com/pgattic/smb1-disasm`
- `cd smb1-disasm`
- `make`

