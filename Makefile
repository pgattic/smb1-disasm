name := smb1-disasm
rom-name := smb

genie: pad
	@./tools/genie.py
	sha1sum $(rom-name).nes
pad: bin
	@./tools/padding.py
bin: asm
	./asm -q main.asm $(rom-name).nes $(rom-name).lst
	@echo Compilation successful!
clean:
	-rm *.nes *.lst asm
asm:
	gcc asm6/asm6.c -o asm

.PHONY: clean bin genie
