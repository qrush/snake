
class Field 
  CELL_SIZE = 10
  START_X = 30
  START_Y = 30
  SIDE = 40
  
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

  def render_cell(x, y, color = "#46350A", stroke = true)
    @app.fill color
    @app.rect x, y, CELL_SIZE, CELL_SIZE
    #cell_size = 10
    #if stroke  
    #@app.fill color
    #@app.rect x*cell_size, y*cell_size, cell_size-1, cell_size-1
    #@app.stroke "#BBB" if stroke
    #@app.line x*cell_size+1, y*cell_size+1, x*cell_size+cell_size-1, y*cell_size
    #@app.line x*cell_size+1, y*cell_size+1, x*cell_size, y*cell_size+cell_size-1
  end

  def paint
    
    spacing = CELL_SIZE + 1
    
    SIDE.times do |x|
      SIDE.times do |y|
        render_cell(START_X + (spacing * x), START_Y + (spacing * y))
      end
    end

  end

end


Shoes.app :height => 500, :width => 500, :title => "Snakes" do
  background "#08ab2e".."#1c582a"
  
  @field = Field.new(self)
  @field.paint
=begin 
  #animate(1) { @status.replace "Time: #{Time.now.strftime('%T')}" }
  
  flow :margin => 1 do
    button("Beginner") { new_game :beginner }
    button("Intermediate") {new_game :intermediate }
    button("Expert") { new_game :expert }
  end
=end 
  stack do @status = para :stroke => white end  end

