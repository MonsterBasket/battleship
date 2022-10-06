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
    pos = gets
    return place_ship_random ship if pos[0].downcase == 'r'
    @board.verify_coord pos
    puts "#{pos.chomp.upcase}, Great! Now do you want that going across, or down?"
    print '(type d for down, or just press enter for across): '
    direction = gets[0]
    x = pos[0].upcase.ord - 65 # converts A-J into 0-9
    y = pos[1].to_i
    @board.verify_pos self, ship, x, y, direction
  end

  def place_ship_random(ship)
    down = [true, false].sample
    x = down ? rand(10) : rand(10 - ship.size)
    y = down ? rand(10 - ship.size) : rand(10)
    @board.verify_pos(self, ship, x, y, down ? 'd' : '', true)
  end

  def attack(opponent)
    pos = opponent.board.verify_coord gets
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
      "Hit! You've sunk the enemy's #{ship.name}!"
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
