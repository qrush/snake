require 'field'

class Food
  attr_reader :cells

  def initialize(snake)
    @snake = snake
    @cells = []
  end
  
  def create
    found = false
    
    while !found
     food = Field.rand
     found = !@snake.cells.include?(food)
    end
    
    cells << food
    
    return food
  end

end

