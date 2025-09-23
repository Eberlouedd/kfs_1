KERNEL = kernel.bin
ISO = kernel.iso
GRUBDIR := /usr/lib/grub/i386-pc

# AJOUTE cette variable si tu veux
SRCS   := kernel/kernel.c kernel/helpers.c
OBJS   := $(SRCS:.c=.o) boot.o

all: $(ISO)

boot.o: boot/boot.asm
	nasm -f elf32 $< -o $@

kernel/%.o: kernel/%.c kernel/include/helpers.h
	gcc -m32 -ffreestanding -fno-builtin -fno-stack-protector -nostdlib -nodefaultlibs -Iinclude -c $< -o $@

$(KERNEL): $(OBJS) linker.ld
	ld -m elf_i386 -T linker.ld $(OBJS) -o $(KERNEL)

$(ISO): $(KERNEL) iso/boot/grub/grub.cfg
	cp $(KERNEL) iso/boot/kernel.bin
	grub-mkrescue -d $(GRUBDIR) -o $(ISO) iso

clean:
	rm -f kernel/*.o boot.o $(KERNEL)
	rm -f iso/boot/kernel.bin

fclean: clean
	rm -f $(ISO)

re: fclean all