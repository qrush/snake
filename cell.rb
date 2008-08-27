require 'constants'

class Cell
  attr_accessor :status

  def initialize(app, row, col)
    @app = app
    @x = START_X + (CELL_SIZE * row)
    @y = START_Y + (CELL_SIZE * col)
    @status = Status::GROUND
  end
  
  def paint(status)
    @status = status
    color = COLORS[@status]
    
    @app.fill color
    @app.strokewidth 0
    #@app.oval(@x, @y, 20, 20)
    @app.rect :left => @x, :top => @y, :width => CELL_SIZE, :height => CELL_SIZE
  end
end
