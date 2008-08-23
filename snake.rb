class Logger
  def self.debug(msg)
#    p msg
  end
end

class Colors
  GROUND = "#46350A"
  SNAKE_RED = "#B02222"
  TEST = "#00f"
end

class Cell
  SIZE = 25
  START_X = 50
  START_Y = 50
  
  def initialize(app, row, col)
    @app = app
    @row = row
    @col = col
    
    spacing = SIZE + 1
    @x = START_X + (spacing * row)
    @y = START_Y + (spacing * col)
  end
  
  def paint(color = Colors::GROUND)
    @app.fill color
    @app.rect :left => @x, :top => @y, :width => SIZE, :height => SIZE
  end
end

class Snake  
  attr_reader :segments, :direction
  
  DIRECTIONS = {
    :up => [0, -1],
    :down => [0, 1],
    :left => [-1, 0],
    :right => [1, 0]
  }
  
  def initialize(field)
    Logger.debug "New snake!"
    @field = field
    @segments = [Field.rand]
    @direction = :right
  end
  
  def head
    @segments[0]
  end
  
  def turn(key)
    @direction = key if DIRECTIONS.keys.include?(key)
  end
  
  def move
    dir = DIRECTIONS[@direction]
    Logger.debug @direction
    @segments[0] = [head[0] + dir[0], head[1] + dir[1]]
    
    
    @segments.each do |seg|
      @field.cells[Field::SIDE * seg[0] + seg[1]].paint(Colors::SNAKE_RED)
    end

  end
end

class Field
  attr_reader :cells
  SIDE = 15
  
  def initialize(app)
    @app = app
    @cells = []
    
    SIDE.times do |x|
      SIDE.times do |y|
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
      p = Proc.new { (Kernel.rand * 100 % SIDE - 1).to_i }
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
  #animate(1) { @field.paint }
  animate(1) do
  @status.replace "Time: #{Time.now.strftime('%T')}" 
  end
  
  animate(10) do |a| 
      
    @snake.move
  end
  
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

