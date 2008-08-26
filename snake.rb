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
        
    if center[0] - @cells.first[0] == 0
      @direction = center[1] > @cells.first[1] ? :down : :up
    else
      slope = (center[1] - @cells.first[1]) / (center[0] - @cells.first[0])
      
      if slope.zero?
        @direction = center[0] > @cells.first[0] ? :right : :left
      elsif slope > 0
        @direction = :left
      else
        @direction = :right
      end
    end
  end
  
  def turn(key)
    @direction = key if DIRECTIONS.keys.include?(key)
  end
  
  def move
    dir = DIRECTIONS[@direction]
    cell = [@cells.first[0] + dir[0], @cells.first[1] + dir[1]]
    
    inside = Proc.new { |x| x.between?(0, FIELD_SIZE - 1) }
    @moving = inside.call(cell[0]) && inside.call(cell[1])
    
    if @moving
    
      if @food.cells.include?(cell)
        @size = @size + 1
        p "OM NOM NOM, size: #{@size}"
        @food.cells.delete(cell)
        bake
      end 
      p "MOVING TO #{cell.inspect}"
      
      @cells.insert(0, cell)
      
      
      if @cells.size > @size
        #delete the tail
        tail = @cells.delete_at(@size)
        @field.paint(tail[0], tail[1])
      end
            
      @field.paint(@cells.first[0], @cells.first[1], Colors::SNAKE_RED) 
      
      p "MOVING!"
      @cells.each do |c|
        p "    " + c.inspect
      end
      
      p "=========="
    end
  end
end

