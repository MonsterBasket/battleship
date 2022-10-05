class Player
  attr_accessor :ships, :board
  attr_reader :status

  def initialize
    @board = Board.new
    @ships = []
    @status = []
    create_ships
    create_status
  end

  def create_ships
    @ships << Ship.new("Carrier", 5)
    @ships << Ship.new("Battleship", 4)
    @ships << Ship.new("Cruiser", 3)
    @ships << Ship.new("Submarine", 3)
    @ships << Ship.new("Destroyer", 2)
  end

  def create_status
    @ships.each do |ship|
      @status << ship.name
      @status << '■' * ship.size
    end
  end

  def place_ship(ship)
    puts "\nWhere would you like to place your #{ship.name}?"
    print '(Type a coordinate from A0-J9 or R for random): '
    pos = verify_coord gets
    return place_ship_random ship if pos == 'r'
    puts "#{pos.chomp.upcase}, Great! Now do you want that going across, or down?"
    print '(type d for down, or just press enter for across): '
    direction = gets[0]
    x = pos[0].upcase.ord - 65 # converts A-J into 0-9
    y = pos[1].to_i
    verify_pos ship, x, y, direction
  end

  def place_ship_random(ship)
    down = [true, false].sample
    x = down ? rand(10) : rand(10 - ship.size)
    y = down ? rand(10 - ship.size) : rand(10)
    verify_pos(ship, x, y, down ? 'd' : '', true)
  end

  def verify_coord(pos)
    if pos[0].match(/[a-jA-J]/) && pos[1].match(/[0-9]/)
      pos[0] + pos[1]
    elsif pos[0].downcase == 'r'
      pos[0].downcase
    else
      puts "That's not a valid coordinate, please try again."
      verify_pos gets
    end
  end

  def verify_pos(ship, x, y, direction, psr = false)
    counter_x = counter_y = 0
    if direction == 'd'
      return fail_pos ship, psr if 10 - y < ship.size
    elsif 10 - x < ship.size
      return fail_pos ship, psr
    end
    ship.size.times do
      return fail_pos ship, psr if @board.coords[y + counter_y][x + counter_x] != " "

      direction == 'd' ? counter_y += 1 : counter_x += 1
    end
    system('clear') || system('cls')
    ship.record x, y, direction
    @board.draw_ship ship, x, y, direction, status
  end

  def fail_pos(ship, psr)
    return place_ship_random ship if psr

    puts "It doesn't fit there, please try again."
    place_ship ship
  end
end