#include <stdint.h>
#include "include/helpers.h"

#define VGA_MEM ((volatile uint16_t*)0xB8000)
#define VGA_WIDTH 80
#define VGA_HEIGHT 25
static uint8_t vga_color = 0x07;

void clear_screen() {
    for (int y = 0; y < VGA_HEIGHT; y++)
        for (int x = 0; x < VGA_WIDTH; x++)
            VGA_MEM[y * VGA_WIDTH + x] = ((uint16_t)vga_color << 8) | ' ';
}

void print(const char *s) {
    size_t len = strlen(s);
    for (size_t i = 0; i < len; i++) {
        VGA_MEM[i] = ((uint16_t)vga_color << 8) | (uint8_t)s[i];
    }
}

void kernel_main(void) {
    clear_screen();
    print("42");
    for(;;) __asm__ __volatile__("hlt");
}