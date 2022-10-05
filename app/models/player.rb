class Player
  attr_accessor :ships, :board
  attr_reader :status, :name

  def initialize(name)
    @name = name
    @board = Board.new name
    @ships = []
    @status = []
    create_ships
    create_status
  end

  def create_ships
    @ships << Ship.new('Carrier', 5)
    @ships << Ship.new('Battleship', 4)
    @ships << Ship.new('Cruiser', 3)
    @ships << Ship.new('Submarine', 3)
    @ships << Ship.new('Destroyer', 2)
  end

  def create_status
    @ships.each do |ship|
      @status << ship.name + ' ' * (10 - ship.name.length) + '  |'
      @status << '■' * ship.size + ' ' * (10 - ship.size) + '  |'
    end
  end

  def place_ship(ship)
    puts "\nWhere would you like to place your #{ship.name}?"
    print '(Type a coordinate from A0-J9 or R for random): '
    pos = verify_coord gets, board
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

  def verify_coord(pos, board)
    if pos[0].match(/[a-jA-J]/) && pos[1].match(/[0-9]/)
      if board.printed_coords[pos[1].to_i][pos[0].upcase.ord - 65] != ' '
        puts "You've already used that spot, please try again."
        verify_coord gets, board
      else
        pos[0] + pos[1]
      end
    elsif pos[0].downcase == 'r'
      pos[0].downcase
    else
      puts "That's not a valid coordinate, please try again."
      verify_coord gets, board
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
      return fail_pos ship, psr if @board.private_coords[y + counter_y][x + counter_x] != ' '
      direction == 'd' ? counter_y += 1 : counter_x += 1
    end
    system('clear') || system('cls')
    @board.record_ship ship, x, y, direction
    @board.draw_ship ship, x, y, direction, status if name == 'Player'
  end

  def fail_pos(ship, psr)
    return place_ship_random ship if psr
    puts "It doesn't fit there, please try again."
    place_ship ship
  end

  def attack(opponent)
    pos = verify_coord gets, opponent.board
    x = pos[0].upcase.ord - 65 # converts A-J into 0-9
    y = pos[1].to_i
      return miss opponent, x, y if opponent.board.private_coords[y][x] == ' '
    hit opponent, x, y
  end

  def miss(opponent, x, y)
    opponent.board.printed_coords[y][x] = '•'
    'Your attack missed.'
  end

  def hit(opponent, x, y)
    ship = opponent.board.private_coords[y][x][0]
    ship.health -= 1
    opponent.board.printed_coords[y][x] = 'X'.red
    if ship.health == 0
      update_status ship, opponent
      "Hit!, you've sunk the enemy's #{ship.name}!"
    else
      "Hit!"
    end
    #Enemy attacked "#{(x + 65).chr}#{y}"
  end

  def update_status(ship, opponent)
    index = @ships.find_index {|item| item.name == ship.name} * 2 + 1
    opponent.status[index] = '■'.red * ship.size + ' ' * (10 - ship.size) + '  |'
    binding.pry
  end
end
