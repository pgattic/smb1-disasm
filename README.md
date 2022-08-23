# Super Mario Bros. Disassembly

This is an attempt to organize and streamline the disassembly code for Super Mario Bros. on the NES. This code will still build the same ROM as the original, but be easier to read and work with, and it will come with some nice handy tools! 

It builds the following ROM: 

 - Super Mario Bros. (World).nes `SHA-1: ea343f4e445a9050d4b4fbac2c77d0693b1d0922`

# Setup

## Windows

Install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) and then follow the Linux instructions from there.

## Linux

Make sure you have the following packages installed (should be readily available on nearly any distro through its package manager): 

 - `make`
 - `gcc`
 - `git`
 - `python3`

Then clone this repo, and run `make` from the project folder!

## To-Do

 - Split files up better (make directories for audio, level data, etc.
 - Fully implement png -> 2bpp processing
