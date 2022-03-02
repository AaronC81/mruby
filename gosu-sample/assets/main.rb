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
    puts "Update!"

    if Gosu.button_down?(Gosu::KB_S)
      @y += 2
    elsif Gosu.button_down?(Gosu::KB_W)
      @y -= 2
    end

    if Gosu.button_down?(Gosu::KB_D)
      @x += 2
    elsif Gosu.button_down?(Gosu::KB_A)
      @x -= 2
    end
  end

  # If you miss an argument, the interpreter hangs - not ideal!
  # Is there some MRuby error hook we need to set up?
  def button_down(btn)
    puts "Pressed a key! (#{btn})"
  end
end

Window.new.show
