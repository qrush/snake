require 'constants'

class Cell
  attr_reader :color
  
  def initialize(app, row, col)
    @app = app
    @x = START_X + (CELL_SIZE * row)
    @y = START_Y + (CELL_SIZE * col)
  end
  
  def paint(color = Colors::GROUND)
    @color = color
    @app.fill color
    @app.strokewidth 0
    #@app.oval(@x, @y, 20, 20)
    @app.rect :left => @x, :top => @y, :width => CELL_SIZE, :height => CELL_SIZE
  end
end
