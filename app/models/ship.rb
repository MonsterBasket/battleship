class Ship
  attr_accessor :name, :size, :health

  def initialize(name, size)
    @name = name
    @size = size
    @health = size
  end

  def hit(attacker, opponent, x, y, segment)
    # ship = opponent.board.private_coords[y][x][0]
    @health -= 1
    opponent.board.printed_coords[y][x] = 'X'.red
    opponent.board.borders[y][x] = '■'.red if x < 9 && opponent.board.private_coords[y][x + 1][0] == self && opponent.board.printed_coords[y][x + 1] == 'X'.red
    opponent.board.borders[y][x - 1] = '■'.red if x > 0 && opponent.board.private_coords[y][x - 1][0] == self && opponent.board.printed_coords[y][x - 1] == 'X'.red
    if @health.zero?
      sink opponent
      return "Hit! You've sunk the enemy's #{name}!" if attacker == 'Player'
      return "Hit! The enemy has sunk your #{name}!" if attacker == 'Enemy'
    elsif attacker == 'Player'
      return 'You hit something!' if attacker == 'Player'
    else
      update_status opponent, segment
      "The enemy attacked #{(x + 65).chr}#{y} and hit your #{name}!"
    end
  end

  def sink(opponent)
    index = opponent.ships.find_index {|item| item.name == name} * 2 + 1
    opponent.status[index] = '■'.red * size + ' ' * (10 - size) + '  |'
  end

  def update_status(opponent, segment)
    index = opponent.ships.find_index {|item| item.name == name} * 2 + 1
    square_index = opponent.status[index].to_enum(:scan, /■/).map {Regexp.last_match}[segment + 1 - 1].offset(0)[0]
    # Unfortunately, when the "■■■" is coloured, it's actually more like this "■\e[0;31;49m■\e[0m■".
    # So the above code uses a regex scan to find the index of the nth ■, where n is the segment of ship that was hit
    opponent.status[index][square_index] = '■'.red
  end
end