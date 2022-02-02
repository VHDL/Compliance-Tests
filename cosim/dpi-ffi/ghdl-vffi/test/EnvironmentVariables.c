#include <stdio.h>
#include <stdlib.h>

#include <vffi_user.h>

//int setenv(const char *name, const char *value, int overwrite);
//int unsetenv(const char *name);
//char *getenv(const char *name);
//char *secure_getenv(const char *name);

vffiLine_t* c_getenv(vffiNaturalDimArr_t* name) {
  assert(name != NULL);
  char* name_str = vffiNullTerminatedString(name);
  printf("c_getenv name : %p '%s' [%d]\n", name->data, name_str, strlen(name_str));

  const char* s = getenv(name_str);
  printf("%s :%s\n", name_str, (s!=NULL)? s : "getenv returned NULL");

  return lineFromString(s);
}
