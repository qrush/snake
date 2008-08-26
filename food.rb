require 'field'

class Food
  attr_reader :foods

  def initialize(snake)
    @snake = snake
    @foods = []
  end
  
  def create
    found = false
    
    while !found
     food = Field.rand
     found = !@snake.segments.include?(food)
    end
    
    foods << food
    
  end

end

