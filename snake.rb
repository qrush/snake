class Colors
  GROUND = "#46350A"
  SNAKE_RED = "#B02222"
end

class Cell
  SIZE = 10
  START_X = 30
  START_Y = 30

  def initialize(app, x, y)
    @app = app
    @x = x
    @y = y
  end
  
  def paint(snake)
  
    if snake.segments.include?([@x, @y])
      color = Colors::SNAKE_RED
    else
      color = Colors::GROUND
    end
    
    spacing = SIZE + 1
    x = START_X + (spacing * @x)
    y = START_Y + (spacing * @y)
    
    @app.fill color
    @app.rect x, y, SIZE, SIZE
  end
end

class Snake  
  attr_reader :segments
  
  def initialize
    @segments = [Field.rand]
  end

end

class Field
  SIDE = 40
  
  def initialize(app)
    @app = app
    @cells = []
    @snake = Snake.new
    
    SIDE.times do |x|
      SIDE.times do |y|
        @cells << Cell.new(app, x, y)
      end
    end
  end

  def paint
    @cells.each do |c|
      c.paint(@snake)
    end
  end
  
  class << self
    def rand
      p = Proc.new { (Kernel.rand * 100 % SIDE - 1).to_i }
      
      [p.call, p.call]
    end
  end
end


Shoes.app :height => 500, :width => 500, :title => "Snakes" do
  background "#08ab2e".."#1c582a"
  
  @field = Field.new(self)
  @field.paint
  #animate(1) { @status.replace "Time: #{Time.now.strftime('%T')}" }
  
=begin 
  flow :margin => 1 do
    button("Beginner") { new_game :beginner }
    button("Intermediate") {new_game :intermediate }
    button("Expert") { new_game :expert }
  end
=end 
  stack do @status = para :stroke => white end  end

