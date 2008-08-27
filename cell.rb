require 'constants'

class Cell
  attr_accessor :status

  def initialize(app, row, col)
    @app = app
    @x = START_X + (CELL_SIZE * row)
    @y = START_Y + (CELL_SIZE * col)
    @status = Status::GROUND
  end
  
  def paint(status, head)
    @status = status
    @app.fill COLORS[@status]
    @app.rect :left => @x, :top => @y, :width => CELL_SIZE, :height => CELL_SIZE
  end
end
