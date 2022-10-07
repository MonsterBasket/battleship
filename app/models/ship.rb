class Ship
  attr_accessor :name, :size, :health

  def initialize(name, size)
    @name = name
    @size = size
    @health = size
  end

  def hit(attacker, opponent, x, y, segment)
    @health -= 1
    opponent.board.printed_coords[y][x] = 'X'.red
    opponent.board.borders[y][x] = '■'.red if x < 9 && opponent.board.private_coords[y][x + 1][0] == self && opponent.board.printed_coords[y][x + 1] == 'X'.red
    opponent.board.borders[y][x - 1] = '■'.red if x > 0 && opponent.board.private_coords[y][x - 1][0] == self && opponent.board.printed_coords[y][x - 1] == 'X'.red
    if @health.zero?
      game_over = sink opponent
      return ["\nHit at #{(x + 65).chr}#{y}! You've sunk the enemy's #{name}!", game_over] if attacker == 'Player'
      return ["Hit at #{(x + 65).chr}#{y}! The enemy has sunk your #{name}!", game_over] if attacker == 'Enemy'
    elsif attacker == 'Player'
      return ["\nYou hit something at #{(x + 65).chr}#{y}!", false] if attacker == 'Player'
    else
      update_status opponent, segment
      ["The enemy attacked #{(x + 65).chr}#{y} and hit your #{name}!", false]
    end
  end

  def sink(opponent)
    index = opponent.ships.index(self) * 2 + 1
    opponent.status[index] = '■'.red * size + ' ' * (10 - size) + '  |'
    return true if opponent.ships.sum { |ship| ship.health }.zero?
    false
  end

  def update_status(opponent, segment)
    index = opponent.ships.index(self) * 2 + 1
    square_index = opponent.status[index].to_enum(:scan, /■/).map {Regexp.last_match}[segment + 1 - 1].offset(0)[0]
    # Unfortunately, when the "■■■" is coloured, it's actually more like this "■\e[0;31;49m■\e[0m■".
    # So the above code uses a regex scan to find the index of the nth ■, where n is the segment of ship that was hit
    opponent.status[index][square_index] = '■'.red
  end
end