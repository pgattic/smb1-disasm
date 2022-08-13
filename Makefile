name := smb1-disasm

genie: bin
	./genie
bin: asm
	./asm -q smb.asm smb.nes smb.lst
clean:
	-rm *.nes *.lst asm
asm:
	gcc asm6/asm6.c -o asm

.PHONY: clean bin genie
