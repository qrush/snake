SPEED = 10
FIELD_SIZE = 25
CELL_SIZE = 15
START_X = 50
START_Y = 50

class Logger
  def self.debug(msg)
    p msg
  end
end

class Colors
  GROUND = "#46350A"
  SNAKE_RED = "#B02222"
end

class Cell
  attr_reader :color
  
  def initialize(app, row, col)
    @app = app
    @x = START_X + (CELL_SIZE * row)
    @y = START_Y + (CELL_SIZE * col)
  end
  
  def paint(color = Colors::GROUND)
    @color = color
    @app.fill color
    @app.strokewidth 0
    #@app.oval(@x, @y, 20, 20)
    @app.rect :left => @x, :top => @y, :width => CELL_SIZE, :height => CELL_SIZE
  end
end

class Snake  
  attr_reader :moving
  
  DIRECTIONS = {
    :up => [0, -1],
    :down => [0, 1],
    :left => [-1, 0],
    :right => [1, 0]
  }
  
  def initialize(field)
    @field = field
  end
  
  def reset
    @moving = true   
    @segments = [Field.rand]
    
    center = [FIELD_SIZE / 2, FIELD_SIZE / 2]
        
    # moving the snake to the center from its random spot
    if center[0] - head[0] == 0
      @direction = center[1] > head[1] ? :down : :up
    else
      slope = (center[1] - head[1]) / (center[0] - head[0])
      
      if slope.zero?
        @direction = center[0] > head[0] ? :right : :left
      elsif slope > 0
        @direction = :left
      else
        @direction = :right
      end
    end
  end
  
  def head
    @segments[0]
  end
  
  def turn(key)
    @direction = key if DIRECTIONS.keys.include?(key)
  end
  
  def paint
    @segments.each do |seg|
      @field.cells[FIELD_SIZE * seg[0] + seg[1]].paint(Colors::SNAKE_RED)
    end
    
    @field.cells[FIELD_SIZE * @tail[0] + @tail[1]].paint
  end
  
  def move
    dir = DIRECTIONS[@direction]
    row, col = head[0] + dir[0], head[1] + dir[1]
    
    inside = Proc.new { |x| x.between?(0, FIELD_SIZE - 1) }
    @moving = inside.call(row) && inside.call(col)
    
    if @moving
      @tail = @segments.last.dup
      @segments[0] = [row, col]
    end
  end
end

class Field
  attr_reader :cells
  
  def initialize(app)
    @app = app
    @cells = []
    
    FIELD_SIZE.times do |x|
      FIELD_SIZE.times do |y|
        @cells << Cell.new(app, x, y)
      end
    end
  end

  def reset
    side = CELL_SIZE * FIELD_SIZE
    @app.fill Colors::GROUND
    @app.strokewidth 0
    @app.rect(START_X, START_Y, side, side)
  end
  
  class << self
    def rand
      p = Proc.new { (Kernel.rand * 100 % FIELD_SIZE - 1).to_i }
      [p.call, p.call]
    end
  end
end


Shoes.app :height => 500, :width => 500, :title => "Snakes" do
  background "#08ab2e".."#1c582a"
  
  def new_game
    @field.reset
    @snake.reset
  end
  
  @field = Field.new(self)
  @snake = Snake.new(@field)
  
  new_game
  
  animate(SPEED) do
    if @snake.moving
      @snake.move 
      @snake.paint 
      @status.replace "Time: #{Time.now.strftime('%T')}" 
    else
      @status.replace "Fail!"
    end
  end
  
  keypress do |k|
    @snake.turn(k)    
    new_game if k == :control_n
  end
=begin 
  flow :margin => 4 do
    button("New Game") { new_game }
  end
=end  
  stack do @status = para :stroke => white end 

 end

