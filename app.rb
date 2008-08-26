require 'field'
require 'snake'
require 'food'

Shoes.app :height => 500, :width => 500, :title => "Snakes" do
  background Colors::BG_TOP..Colors::BG_BOTTOM
  
  def new_game
    @field.reset
    @snake.reset
    @food.create
  end
  
  @field = Field.new(self)
  @snake = Snake.new(@field)
  @food = Food.new(@field, @snake)
  new_game
  
  animate(SPEED) do
    if @snake.moving
      @snake.move 
      @snake.paint 
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
