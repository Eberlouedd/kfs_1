#ifndef HELPERS_H
#define HELPERS_H

#include <stddef.h>
#include <stdint.h>

/* Helpers de base pour environnement freestanding */
size_t strlen(const char *s);
int    strcmp(const char *a, const char *b);
void  *memset(void *dst, int c, size_t n);
void  *memcpy(void *dst, const void *src, size_t n);

#endif