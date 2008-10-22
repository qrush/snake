require 'field'
require 'snake'

Shoes.app :height => WINDOW_SIZE + 40, :width => WINDOW_SIZE, :title => "Snake" do
  background "#08ab2e".."#1c582a"
  @style = {:stroke => white, :font => "Monospace", :align => "center"}
  
  stack do 
    @status = para @style.merge(:size => 10, :margin_top => 10, :margin_bottom => 0) 
    @status.replace "Welcome to Snake!"
  end
  
  @field = Field.new(image(IMAGE_SIZE, IMAGE_SIZE))
  
  animate(SPEED) do
    if @snake.moving
      @snake.move
      @status.replace "Your Score: #{@snake.score} | High Score: #{@snake.high_score}" 
    elsif @new_game
      @status.replace "Game over!"
    end
  end
  
  keypress do |k|
    @snake.turn(k)
    new_game if k == " "
  end
  
  stack do
    para "Controls: Up, Down, Left, Right to move. Space to start new game.", @style.merge(:size => 7)
  end 
  
  def new_game
    @new_game = true
    @field.reset
    @snake.reset
  end
  
  setup_game = lambda {
    @field.reset
    @snake = Snake.new(@field)
  }.call
end

