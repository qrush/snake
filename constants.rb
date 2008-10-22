SPEED = 15
FIELD_SIZE = 25
CELL_SIZE = 13
WINDOW_SIZE = 380
IMAGE_SIZE = 354
START_X = 27
START_Y = 25

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

DIRECTIONS = {
  :up => [0, -1],
  :down => [0, 1],
  :left => [-1, 0],
  :right => [1, 0]
}

UTURNS = {
  :up => "down",
  :down => "up",
  :left => "right",
  :right => "left",
}
