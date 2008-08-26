require 'field'

class Food
  attr_reader :cells

  def initialize(field, snake)
    @field = field
    @snake = snake
    @cells = []
  end
  
  def create
    found = false
    
    while !found
     food = Field.rand
     found = !@snake.segments.include?(food)
    end
    
    cells << food
    
    @field.paint(food[0], food[1], Colors::FOOD)
  end

end

