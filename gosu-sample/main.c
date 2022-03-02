#include <mruby.h>
#include <mruby/compile.h>
#include <stdio.h>
#include <dirent.h>

int main(void) {
  mrb_state *mrb = mrb_open();

  FILE* source_file = fopen("assets/main.rb", "r");
  mrb_load_file(mrb, source_file);

  fclose(source_file);
}
