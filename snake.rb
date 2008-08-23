class Colors
  GROUND = "#46350A"
  SNAKE_RED = "#B02222"
end

class Cell
  SIZE = 5
  START_X = 30
  START_Y = 30

  def initialize(app, row, col)
    @app = app
    @row = row
    @col = col
    
    spacing = SIZE + 1
    @x = START_X + (spacing * row)
    @y = START_Y + (spacing * col)
  end
  
  def paint
  
=begin
    if snake.segments.include?([@x, @y])
      color = Colors::SNAKE_RED
    else
    end
=end
      color = Colors::GROUND
    
    @app.fill color
   # @app.rect @x, @y, SIZE, SIZE
  end
end

class Snake  
  attr_reader :segments
  
  def initialize
    @segments = [Field.rand]
  end
  
  def up
    @segments[0] = [head[0], head[1] - 1]
  end
  
  def down
    @segments[0] = [head[0], head[1] + 1]
  end
  
  def left
    @segments[0] = [head[0] - 1, head[1]]
  end

  def right
    @segments[0] = [head[0] + 1, head[1]]
  end
  
  def head
    @segments[0]
  end

end

class Field
  attr_reader :snake
  SIDE = 10
  
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
    @cells.each(&:paint)
  end
  
  class << self
    def rand
      p = Proc.new { (Kernel.rand * 100 % SIDE - 1).to_i }
      
      [p.call, p.call]
    end
  end
end


Shoes.app :height => 250, :width => 250, :title => "Snakes" do
  background "#08ab2e".."#1c582a"
  
  @field = Field.new(self)
  #animate(1) { @field.paint }
  animate(10) { 
  @status.replace "Time: #{Time.now.strftime('%T')}" 
  @field.paint
  }
  keypress do |k|
    case k
      when :up
        @field.snake.up
      when :down
        @field.snake.down
      when :left
        @field.snake.left
      when :right
        @field.snake.right
    end
  end
  
=begin 
  flow :margin => 1 do
    button("Beginner") { new_game :beginner }
    button("Intermediate") {new_game :intermediate }
    button("Expert") { new_game :expert }
  end
=end 
  stack do @status = para :stroke => white end  end

