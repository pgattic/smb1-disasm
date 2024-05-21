# Super Mario Bros. Disassembly

This is an attempt to organize and streamline the disassembly code for Super Mario Bros. This code should still build the same ROM as the original, but with code that is easier to read and work with.

It builds the following ROM:

- smb.nes `sha1: ea343f4e445a9050d4b4fbac2c77d0693b1d0922`

## Progress

So far, the assembly code and data (excluding CHR) is all in one big asm file. I have a few milestones that I am hoping to reach:

- [ ] Separate assembly files into smaller, more specific pieces
- [ ] Extract more binary data into separate files (level maps, tile maps, music, etc.)

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

## Usage

Since the original [SMBDIS.ASM](https://gist.github.com/1wErt3r/4048722) does not provide any requirements for redistribution, this work is for my personal use only, and not for redistribution. I have reached out to doppelganger for clarification on what I am allowed to do with his original work.

## Credits

- Nintendo R&D4, for developing the original Super Mario Bros. game that we cherish
- doppelganger/doppelheathen, for creating the original [SMBDIS.ASM](https://gist.github.com/1wErt3r/4048722), of which this project is a derivative

