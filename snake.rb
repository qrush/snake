SPEED = 10
FIELD_SIZE = 15
CELL_SIZE = 20
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
  TEST = "#00f"
end

class Cell
  
  def initialize(app, row, col)
    @app = app
    @row = row
    @col = col
    
    spacing = CELL_SIZE + 1
    @x = START_X + (spacing * row)
    @y = START_Y + (spacing * col)
  end
  
  def paint(color = Colors::GROUND)
    @app.fill color
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
    Logger.debug "New snake!"
    @field = field
    @segments = [[5, 5]]
    @direction = :up
    @moving = true
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
    
    row = head[0] + dir[0]
    col = head[1] + dir[1]
    
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

  def paint
    Logger.debug "Painting field..."
    @cells.each(&:paint)
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
  
  Logger.debug "Making field..."
  @field = Field.new(self)
  @field.paint
  
  @snake = Snake.new(@field)
  
  animate(SPEED) { 

    if @snake.moving
      @snake.move 
      @snake.paint 
      @status.replace "Time: #{Time.now.strftime('%T')}" 
    else
      @status.replace "Fail!"
    end
  }
  
  keypress do |k|
    @snake.turn(k)
  end
  
=begin 
  flow :margin => 1 do
    button("Beginner") { new_game :beginner }
    button("Intermediate") {new_game :intermediate }
    button("Expert") { new_game :expert }
  end
=end 
  stack do @status = para :stroke => white end  end

