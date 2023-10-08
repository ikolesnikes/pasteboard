#import "Cocoa/Cocoa.h"

// Copies the given string to the general pasteboard.
int pasteboard_copy(const char *str) {
  @autoreleasepool {
    if (!str) {
      return 0;
    }
    NSString *string = [NSString stringWithUTF8String:str];
    if (!string) {
      return 0;
    }
    NSPasteboard *general = [NSPasteboard generalPasteboard];
    [general clearContents];
    return [general setString:string forType:NSPasteboardTypeString] == YES;
  }
}

// Returns a content of the general pasteboard.
// If nothing was pasted or error occured, returns NULL.
// Allocates memory for the content.  The caller is responsible for freeing the
// allocated memory.
char *pasteboard_paste(void) {
  @autoreleasepool {
    // Retrieve a string from the general pasteboard.
    NSPasteboard *general = [NSPasteboard generalPasteboard];
    NSString *string = [general stringForType:NSPasteboardTypeString];
    if (!string) {
      return NULL;
    }
    // Get a c-string and its length in bytes.
    const char *str = [string UTF8String];
    size_t len = strlen(str);
    if (!len || !str) {
      return NULL;
    }
    // Allocate a buffer and copy the c-string into it.
    char *p = malloc(len + 1); // +1 for NULL
    if (!p) {
      return NULL;
    }
    return strcpy(p, str);
  }
}
