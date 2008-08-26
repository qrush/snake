require 'constants'
require 'cell'

class Field
  def initialize(app)
    @app = app
    @cells = []
    
    FIELD_SIZE.times do |x|
      FIELD_SIZE.times do |y|
        @cells << Cell.new(app, x, y)
      end
    end
  end

  def paint(row, col, color = Colors::GROUND)
    @cells[FIELD_SIZE * row + col].paint(color)
  end

  def reset
    side = CELL_SIZE * FIELD_SIZE
    @app.fill Colors::GROUND
    @app.strokewidth 0
    @app.rect(START_X, START_Y, side, side)
  end
  
  class << self
    def rand
      p = Proc.new { (Kernel.rand * 100 % FIELD_SIZE - 1).to_i }
      [p.call, p.call]
    end
  end
end
