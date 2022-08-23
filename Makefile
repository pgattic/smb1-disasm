name := smb1-disasm
rom-name := smb

.PHONY: all bin clean compare genie pad

all: bin pad compare

bin: asm
	@echo Compiling...
	./asm -q main.asm $(rom-name).nes $(rom-name).lst
	@echo Compilation successful! filesize: 
	@stat -L -c %s $(rom-name).nes
pad:
	@./tools/padding.py "$(rom-name).nes" 40976 ff
compare:
	@echo SHA-1 Checksum: 
	@sha1sum $(rom-name).nes
	@sha1sum -c smb.sha1
clean:
	-rm *.nes *.lst asm
genie:
	@./tools/genie.py
asm:
	gcc asm6/asm6.c -o asm
