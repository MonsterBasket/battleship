class Board
  attr_accessor :private_coords, :printed_coords, :borders
  attr_reader :name

  def initialize(name)
    @name = name
    @private_coords = []
    @printed_coords = []
    @borders = []
    10.times do
      @private_coords << Array.new(10, ' ')
      @printed_coords << Array.new(10, ' ')
      @borders << Array.new(9, '|')
    end
  end

  def print_board(status)
    puts '   ' + 'A|B|C|D|E|F|G|H|I|J'.underline + '              |'
    printed_coords.each_with_index do |row, a|
      print " #{a}" + '|'.on_blue
      row.each_with_index do |col, b|
        print "#{col}#{borders[a][b]}".underline.on_blue
      end
      puts '|'.on_blue + ' ' + status[a]
    end
  end

  def record_ship(ship, x, y, direction)
    counter_x = counter_y = 0
    ship.size.times do
      private_coords[y + counter_y][x + counter_x] = [ship, 1]
      direction == 'd' ? counter_y += 1 : counter_x += 1
    end
  end

  def draw_ship (ship, x, y, direction, status)
    counter_x = counter_y = 0
    printed_coords[y][x] = direction == 'd' ? '▲' : '◄'
    borders[y][x] = '■' if direction != 'd'
    loop do
      direction == 'd' ? counter_y += 1 : counter_x += 1
      break if counter_y == ship.size - 1 || counter_x == ship.size - 1
      printed_coords[y + counter_y][x + counter_x] = direction == 'd' ? '█' : '■'
      borders[y][x + counter_x] = '■' if direction != 'd'
    end
    printed_coords[y + counter_y][x + counter_x] = direction == 'd' ? '▼' : '►'
    print_board status
  end
end

# X = hit (but in red)
# 7 = • = miss
# 30 = ▲ = top
# 31 = ▼ = bottom
# 16 = ► = right
# 17 = ◄ = left
# 219 = █ = vertical
# 254 = ■ = horizontal (including dividing lines between pieces)