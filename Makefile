ROM_NAME := smb
ASM := asm6f/asm6f

ASM_EXISTS := $(wildcard $(ASM))

all: $(ROM_NAME).nes

$(ROM_NAME).nes: asm
	@echo "Building $(ROM_NAME).nes..."
	@$(ASM) -q main.asm $@ $(ROM_NAME).lst \
	&& echo "$(ROM_NAME).nes built successfully!" \
	&& sha1sum $@

clean:
	rm -f $(ROM_NAME).nes $(ROM_NAME).lst
	make clean -C asm6f

# Only build assembler if it doesn't already exist. Use its own makefile.
asm:
ifndef ASM_EXISTS
	make -C asm6f
endif

.PHONY: all clean asm

