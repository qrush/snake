require 'constants'
require 'cell'

class Field
  def initialize(app)
    @app = app
    @map = {}
    
    FIELD_SIZE.times do |row|
      FIELD_SIZE.times do |col|
        @map[slugify(row, col)] = Cell.new(app, row, col)
      end
    end
  end

  def paint(cell, status = Status::GROUND, head = false)
    @map[slugify(cell[0], cell[1])].paint(status, head)
  end
  
  def status(cell)
    @map[slugify(cell[0], cell[1])].status
  end
  
  def slugify(row, col)
    sprintf("%s-%s", row, col)
  end

  def reset
    side = CELL_SIZE * FIELD_SIZE
    
    @app.fill @app.black
    margin = 2
    side_with_margin = side + margin * 2
    @app.rect(START_X - margin, START_Y - margin, side_with_margin, side_with_margin)
    
    @app.fill COLORS[Status::GROUND]
    @app.strokewidth 0
    @app.rect(START_X, START_Y, side, side)
    
    @map.each do |key, cell|
      cell.status = Status::GROUND
    end
  end
  
  class << self
    def rand
      [random_cell, random_cell]
    end
    
    private
      def random_cell
         (Kernel.rand * 100 % FIELD_SIZE - 1).to_i
      end
  end
end
