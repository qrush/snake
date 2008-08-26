require 'constants'

class Snake  
  attr_reader :moving, :cells
  
  DIRECTIONS = {
    :up => [0, -1],
    :down => [0, 1],
    :left => [-1, 0],
    :right => [1, 0]
  }
  
  def initialize(field)
    @field = field
    @food = Food.new(self)
  end
  
  def bake
    # Make a new food and get it painted.
    food = @food.create
    @field.paint(food[0], food[1], Colors::FOOD)
  end
  
  def reset
    # Resetting stuff...
    @moving = true   
    @cells = [Field.rand]
    @size = 1
    p @cells
    bake()
    
    # moving the snake to the center from its random spot
    center = [FIELD_SIZE / 2, FIELD_SIZE / 2]
        
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
    @cells[0]
  end
  
  def turn(key)
    @direction = key if DIRECTIONS.keys.include?(key)
  end
  
  def paint(grow = false)
    @cells.each do |seg|
      @field.paint(seg[0], seg[1], Colors::SNAKE_RED)
    end
      
    @field.paint(@tail[0], @tail[1]) if !grow
  end
  
  def move
    dir = DIRECTIONS[@direction]
    cell = [head[0] + dir[0], head[1] + dir[1]]
    
    inside = Proc.new { |x| x.between?(0, FIELD_SIZE - 1) }
    @moving = inside.call(cell[0]) && inside.call(cell[1])
    
    if @moving
    
      @tail = @cells.last.dup
      @cells.push(cell)
      
      if @food.cells.include?(cell)
        @size = @size + 1
        p "OM NOM NOM, size: #{@size}"
        
        @food.cells.delete(cell)
        bake
        #paint(true)
       # @cells << cell
      else
        @cells.shift
      end 
        paint 
      
      p @cells
      
      
    end
  end
end

