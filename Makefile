ROM_NAME := smb
ASM_DIR := asm6f
ASM := $(ASM_DIR)/asm6f

ASM_DIR_EXISTS := $(wildcard $(ASM_DIR))
ASM_EXISTS := $(wildcard $(ASM))

all: $(ROM_NAME).nes

$(ROM_NAME).nes: asm
	@echo "Building $(ROM_NAME).nes..."
	@$(ASM) -q main.asm $@ $(ROM_NAME).lst \
	&& echo "$(ROM_NAME).nes built successfully!" \
	&& sha1sum $@

clean:
	rm -f $(ROM_NAME).nes $(ROM_NAME).lst
	make clean -C $(ASM_DIR)

check: $(ROM_NAME).nes
	@sha1sum -c smb.sha1

# Only build assembler if it doesn't already exist. Use its own makefile.
asm:
ifndef ASM_DIR_EXISTS
	git clone https://github.com/freem/asm6f.git $(ASM_DIR)
endif
ifndef ASM_EXISTS
	make -C $(ASM_DIR)
endif

.PHONY: all clean check asm

