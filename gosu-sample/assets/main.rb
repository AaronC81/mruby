class Window < Gosu::Window
  def initialize
    @x = 10
    @y = 10
    super(500, 500)
  end

  def draw
    Gosu.draw_rect(@x, @y, 100, 100, Gosu::Color::RED)
  end

  def update
    puts "Update..."
    @x += 2
  end
end

Window.new.show
