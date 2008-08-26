require 'constants'

class Snake  
  attr_reader :moving, :segments
  
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

