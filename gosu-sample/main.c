#include <mruby.h>
#include <mruby/compile.h>

int main(void) {
  mrb_state *mrb = mrb_open();

  mrb_load_string(mrb,
    "class Window < Gosu::Window\n"
    "  def initialize\n"
    "    super(500, 500)\n"
    "  end\n"
    "  \n"
    "  def draw\n"
    "    Gosu.draw_rect(10, 10, 100, 100, Gosu::Color::RED)\n"
    "  end\n"
    "end\n"
    "Window.new.tick\n"
  );

  mrb_close(mrb);
}
