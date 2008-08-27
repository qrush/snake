require 'constants'

class Snake  
  attr_reader :moving, :cells
  
  def initialize(field)
    @field = field
    @keycheck = false
  end
  
  def bake
    found = false
    
    while !found
     food = Field.rand
     found = @field.status(food) == Status::GROUND
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
    return if !@keycheck
   
    # don't let them pull a uturn
    if DIRECTIONS.keys.include?(key)
      uturn = UTURNS[@direction]
      
      if key.to_s != uturn || @size == 1
        @direction = key 
      end
    end
    
    @keycheck = false
  end
  
  def inside(field)
    field.between?(0, FIELD_SIZE - 1)
  end
  
  def move
    @keycheck = true
    dir = DIRECTIONS[@direction]
    cell = [@cells.first[0] + dir[0], @cells.first[1] + dir[1]]
    
    @moving = inside(cell[0]) && inside(cell[1])
    return if !@moving
    
    status = @field.status(cell)
    
    case status
    when Status::FOOD
      @size = @size + 1
      bake
    when Status::SNAKE
      @moving = false
      return
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

