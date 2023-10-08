#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int pasteboard_copy(const char *str);
char *pasteboard_paste(void);

int main(int argc, char *argv[])
{
  pasteboard_copy("hello from C");
  char *str;
  if ((str = pasteboard_paste())) {
    puts(str);
    free(str);
  }
  return 0;
}
