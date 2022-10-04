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
    puts "Where would you like to place your #{ship.name}?"
    puts '(Type a letter between A and J and a number between 0 and 9)'
    pos = verify_coord gets
    puts "#{pos.chomp.upcase}, Great! Now do you want that going across, or down?"
    puts '(type d for down, or just press enter for across)'
    direction = gets[0]
    x = pos[0].upcase.ord - 65 # converts A-J into 0-9
    y = pos[1].to_i
    verify_pos ship, x, y, direction
  end

  def verify_coord(pos)
    if pos[0].match(/[a-zA-Z]/) && pos[1].match(/[0-9]/)
      pos[0] + pos[1]
    else
      puts "That's not a valid coordinate, please try again."
      verify gets
    end
  end

  def verify_pos(ship, x, y, direction)
    counter_x = counter_y = 0
    if direction == 'd'
      return fail_pos ship if 10 - y < ship.size
    elsif 10 - x < ship.size
      return fail_pos ship
    end
    ship.size.times do
      return fail_pos ship if @board.coords[y + counter_y][x + counter_x] != " "

      direction == 'd' ? counter_y += 1 : counter_x += 1
    end
    draw_ship ship, x, y, direction
  end

  def fail_pos(ship)
    puts "It doesn't fit there, please try again."
    place_ship ship
  end

  def draw_ship (ship, x, y, direction)
    counter_x = counter_y = 0
    # if direction == 'd'
      @board.coords[y][x] = direction == 'd' ? '▲' : '◄'
      @board.borders[y][x] = '■' if direction != 'd'
      loop do
        direction == 'd' ? counter_y += 1 : counter_x += 1
        break if counter_y == ship.size - 1 || counter_x == ship.size - 1
        @board.coords[y + counter_y][x + counter_x] = direction == 'd' ? '█' : '■'
        @board.borders[y][x + counter_x] = '■' if direction != 'd'
      end
      @board.coords[y + counter_y][x + counter_x] = direction == 'd' ? '▼' : '►'
    # else
    #   @board.coords[y][x] = '◄'
    #   @board.borders[y][x] = '■'
    #   loop do
    #     counter += 1
    #     break if counter == ship.size - 1
    #     @board.coords[y][x + counter] = '■'
    #     @board.borders[y][x + counter] = '■'
    #   end
    #   @board.coords[y][x + counter] = '►'
    # end
    @board.print_board status
  end
end