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

  def print_board(status, history = nil)
    puts '   ' + 'A|B|C|D|E|F|G|H|I|J'.underline + '              |'
    printed_coords.each_with_index do |row, a|
      print " #{a}" + '|'.on_blue
      row.each_with_index do |col, b|
        print "#{col}#{borders[a][b]}".underline.on_blue
      end
      puts '|'.on_blue + ' ' + status[a]
    end
  end

  # This is for confirming that the entered coordinate is valid and not used.
  def verify_coord(pos)
    if pos[0].match(/[a-jA-J]/) && pos[1].match(/[0-9]/) # will need to drastically change this if I implement an option for board size
      if printed_coords[pos[1].to_i][pos[0].upcase.ord - 65] != ' '
        puts "You've already used that spot, please try again."
        verify_coord gets
      else
        pos[0] + pos[1]
      end
    else
      puts "That's not a valid coordinate, please try again."
      verify_coord gets
    end
  end

  # This is used solely for placing ships before play starts
  def verify_pos(player, ship, x, y, direction, psr = false)
    counter_x = counter_y = 0
    if direction == 'd'
      return fail_pos player, ship, psr if 10 - y < ship.size
    elsif 10 - x < ship.size
      return fail_pos player, ship, psr
    end
    ship.size.times do
      return fail_pos player, ship, psr if private_coords[y + counter_y][x + counter_x] != ' '
      direction == 'd' ? counter_y += 1 : counter_x += 1
    end
    system('clear') || system('cls')
    record_ship ship, x, y, direction
    draw_ship ship, x, y, direction, player.status if name == 'Player'
  end

  def fail_pos(player, ship, psr)
    return player.place_ship_random ship if psr
    puts "It doesn't fit there, please try again."
    player.place_ship ship
  end

  def record_ship(ship, x, y, direction)
    counter_x = counter_y = 0
    ship.size.times do
      private_coords[y + counter_y][x + counter_x] = [ship,  direction == 'd' ? counter_y : counter_x]
      direction == 'd' ? counter_y += 1 : counter_x += 1
    end
  end

  def draw_ship(ship, x, y, direction, status, red = false)
    counter = 1
    if direction == 'd'
      printed_coords[y][x] = red ? '▲'.red : '▲'
      (ship.size - 2).times do
        printed_coords[y + counter][x] = red ? '█'.red : '█'
        counter += 1
      end
      printed_coords[y + counter][x] = red ? '▼'.red : '▼'
    else
      printed_coords[y][x] = red ? '◄'.red : '◄'
      borders[y][x] = red ? '■'.red : '■'
      (ship.size - 2).times do
        printed_coords[y][x + counter] = red ? '■'.red : '■'
        borders[y][x + counter] = red ? '■'.red : '■'
        counter += 1
      end
      printed_coords[y][x + counter] = red ? '►'.red : '►'
    end
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