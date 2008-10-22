require 'constants'
require 'cell'

class Field
  def initialize(img)
    @img = img
    @map = {}
    
    FIELD_SIZE.times do |row|
      FIELD_SIZE.times do |col|
        @map[slugify(row, col)] = Cell.new(img, row, col)
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
    
    @img.fill '#000'
    margin = 2
    side_with_margin = side + margin * 2
    @img.rect(START_X - margin, START_Y - margin, side_with_margin, side_with_margin)
    
    @img.fill COLORS[Status::GROUND]
    @img.strokewidth 0
    @img.rect(START_X, START_Y, side, side)
    
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
