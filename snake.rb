
class Field 
  
  def initialize(app)
    @app = app
    @field = []
=begin
    @w, @h, @bombs = LEVELS[level][0], LEVELS[level][1], LEVELS[level][2]
    @h.times { @field << Array.new(@w) { EmptyCell.new } }
    @game_over = false
    @width, @height, @cell_size = @w * CELL_SIZE, @h * CELL_SIZE, CELL_SIZE
    @offset = [(@app.width - @width.to_i) / 2, (@app.height - @height.to_i) / 2]
    plant_bombs
    @start_time = Time.now
=end
  end

  def paint
  
  end

end


Shoes.app :height => 500, :width => 500, :title => "It's a Snake!" do
  background "#08ab2e".."#1c582a"
  
  
  @field = Field.new(self)
  
  flow :margin => 4 do
    button("Beginner") { new_game :beginner }
    button("Intermediate") {new_game :intermediate }
    button("Expert") { new_game :expert }
  end
  
  stack do @status = para :stroke => white end
  
  animate(5) { @status.replace "Time: #{Time.now}" }
  
  @field.paint
  para "Left click - open cell, right click - put flag, middle click - reveal empty cells", :top => 420, :left => 0, :stroke => white,  :font => "11px"
end

