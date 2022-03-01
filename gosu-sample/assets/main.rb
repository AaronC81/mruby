class Window < Gosu::Window
  def initialize
    super(500, 500)
  end

  def draw
    Gosu.draw_rect(10, 10, 100, 100, Gosu::Color::RED)
  end
end

Window.new.tick
