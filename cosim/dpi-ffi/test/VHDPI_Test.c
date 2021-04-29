#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include <vhdpi_user.h>

// GitHub Actions collapsible/expandable groups
void ghaGStart(char* str) {
  printf("::group::%s\n", str);
  //printf("· %s\n", str);
}

void ghaGEnd() {
  printf("::endgroup::\n");
  //printf("\n");
}

void VHDPI_Test(
  void* v_natural1D_int
) {

  printf("! VHDPI_Test\n");

  return;
}
