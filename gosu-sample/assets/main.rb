puts File.read("assets/main.rb")

class Window < Gosu::Window
  def initialize
    super(500, 500)
    @x = 10
    @y = 10

    @image = Gosu::Image.new("assets/shark.png")
    @sample = Gosu::Sample.new("assets/sound.wav")
  end

  def draw
    @image.draw(@x, @y, 1)
  end

  def update
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
    @sample.play
  end
end

Window.new.show
