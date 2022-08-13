name := smb1-disasm
rom-name := smb

genie: bin
	./genie
bin: asm
	./asm -q smb.asm $(rom-name).nes $(rom-name).lst
	sha1sum $(rom-name).nes
clean:
	-rm *.nes *.lst asm
asm:
	gcc asm6/asm6.c -o asm

.PHONY: clean bin genie
