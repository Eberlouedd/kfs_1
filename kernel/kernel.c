void kernel_main(void) {
    char *video_memory = (char *)0xb8000;
    video_memory[0] = '4';
    video_memory[1] = 0x09;
    video_memory[2] = '2';
    video_memory[3] = 0x09;
}
