require 'field'
require 'snake'

Shoes.app :height => WINDOW_SIZE, :width => WINDOW_SIZE, :title => "Snake" do
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
      @status.replace "Your Score: #{@snake.score} | High Score: #{@snake.high_score}" 
    else
      @status.replace "Game over!"
    end
  end
  
  keypress do |k|
    @snake.turn(k)
    new_game if k == " "
  end
  
  style = {:stroke => white, :font => "Monospace", :align => "center"}
  
  stack do 
    @status = para style.merge(:size => 9, :margin_top => 3) 
  end
  
  stack :margin_top => FIELD_SIZE * CELL_SIZE - 3 do
    para "Controls: Up, Down, Left, Right to move. Space to start new game.", 
      style.merge(:size => 7)
  end end
