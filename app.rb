require 'field'
require 'snake'

Shoes.app :height => WINDOW_SIZE + 40, :width => WINDOW_SIZE, :title => "Snake" do
  background "#08ab2e".."#1c582a"
  
  def new_game
    @field.reset
    @snake.reset
  end
  
  style = {:stroke => white, :font => "Monospace", :align => "center"}
  stack do 
    @status = para style.merge(:size => 10, :margin_top => 20, :margin_bottom => 0) 
      
    @status.replace  "Welcome to Snake!"
  end
  @field = Field.new(image(354,354))
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
  
  stack  do
    para "Controls: Up, Down, Left, Right to move. Space to start new game.", 
      style.merge(:size => 7)
  end 
end
