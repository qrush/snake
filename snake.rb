class Logger
  def self.debug(msg)
    #p msg
  end
end

class Colors
  GROUND = "#46350A"
  SNAKE_RED = "#B02222"
  TEST = "#00f"
end

class Cell
  attr_accessor :paint, :color

  SIZE = 15
  START_X = 50
  START_Y = 50
  
  def initialize(app, row, col)
    @app = app
    @row = row
    @col = col
    @paint = true
    @color = Colors::GROUND
    
    spacing = SIZE + 1
    @x = START_X + (spacing * row)
    @y = START_Y + (spacing * col)
  end
  
  def paint
    if @paint
      #if snake.segments.include?([@row, @col])
      #  color = Colors::SNAKE_RED
      #else
      #  color = Colors::GROUND
      #end
      Logger.debug "Painting cell [#{@row}, #{@col}]"
      
      @app.fill @color
      @app.rect @x, @y, SIZE, SIZE
      @paint = false
    end
  end
end

class Snake  
  attr_reader :segments
  
  def initialize(field)
    @field = field
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
  
  def move
    Logger.debug "Painting snake..."
    
  
    @field.cells[0].paint = true
    @field.cells[0].color = Colors::SNAKE_RED
    @field.cells[0].paint()
    
  end

end

class Field
  attr_reader :cells
  SIDE = 25
  
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
  @snake = Snake.new(@field)
  #animate(1) { @field.paint }
  animate(10) { 
  @status.replace "Time: #{Time.now.strftime('%T')}" 
  @field.paint
  @snake.move
  }
  keypress do |k|
    case k
      when :up
        @snake.up
      when :down
        @snake.down
      when :left
        @snake.left
      when :right
        @snake.right
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

