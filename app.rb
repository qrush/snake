require 'field'
require 'snake'
require 'food'

Shoes.app :height => 500, :width => 500, :title => "Snakes" do
  background "#08ab2e".."#1c582a"
  
  def new_game
    @field.reset
    @snake.reset
  end
  
  @field = Field.new(self)
  @snake = Snake.new(@field)
  new_game
  
  animate(SPEED) do
    if @snake.moving
      @snake.move
      @status.replace "Time: #{Time.now.strftime('%T')}" 
    else
      @status.replace "Fail!"
    end
  end
  
  keypress do |k|
    @snake.turn(k)
    new_game if k == " "
  end
  
  stack do 
    @status = para :stroke => white 
  end end
