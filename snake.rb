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
   # @food = Food.new(self)
  end
  
  def bake
    found = false
    
    while !found
      #  @size = @size + 1hile !found
     food = Field.rand
     found = @field.status(food) #!@snake.cells.include?(food)
    end
    
    @field.paint(food, Status::FOOD)
  end
  
  def reset
    # Resetting stuff...
    @moving = true   
    @cells = [Field.rand]
    @size = 1
    bake
    
    # moving the snake to the center from its random spot
    center = Array.new(2, FIELD_SIZE / 2)
        
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
    
    return if !@moving
          
    if @field.status(cell) == Status::FOOD
      @size = @size + 1
      bake
    end
      
    @cells.insert(0, cell)
    
    # delete the tail
    if @cells.size > @size
      tail = @cells.delete_at(@size)
      @field.paint(tail)
    end
          
    @field.paint(@cells.first, Status::SNAKE)
  end
end

