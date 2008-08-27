SPEED = 10
FIELD_SIZE = 25
CELL_SIZE = 15
START_X = 50
START_Y = 50

class Status
  GROUND = 0
  FOOD = 1
  SNAKE = 2
end

COLORS = { 
  Status::GROUND => "#46350A",
  Status::FOOD => "#E6EF74",
  Status::SNAKE => "#B02222"
}
