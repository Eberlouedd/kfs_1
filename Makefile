KERNEL = kernel.bin
ISO = kernel.iso

all: $(ISO)

$(KERNEL): boot/boot.asm kernel/kernel.c linker.ld
	nasm -f elf32 boot/boot.asm -o boot.o
	gcc -m32 -ffreestanding -c kernel/kernel.c -o kernel.o
	ld -m elf_i386 -T linker.ld boot.o kernel.o -o $(KERNEL)

$(ISO): $(KERNEL) iso/boot/grub/grub.cfg
	mkdir -p iso/boot/grub
	cp $(KERNEL) iso/boot/kernel.bin
	grub-mkrescue -o $(ISO) iso

iso/boot/grub/grub.cfg:
	mkdir -p iso/boot/grub
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo 'menuentry "KFS_1" {' >> iso/boot/grub/grub.cfg
	echo '    multiboot /boot/kernel.bin' >> iso/boot/grub/grub.cfg
	echo '    boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg

run: $(ISO)
	qemu-system-i386 -cdrom $(ISO) -boot d

clean:
	rm -f *.o $(KERNEL) $(ISO)
	rm -f iso/boot/kernel.bin

fclean: clean
	rm -rf iso

re: fclean all
