class Ship
  attr_accessor :name, :size, :health

  def initialize(name, size)
    @name = name
    @size = size
    @health = size
  end

  def hit(attacker, opponent, x, y)
    # ship = opponent.board.private_coords[y][x][0]
    @health -= 1
    opponent.board.printed_coords[y][x] = 'X'.red.bold
    if @health == 0
      update_status opponent
      return "Hit! You've sunk the enemy's #{name}!" if attacker == 'Player'
      return "Hit! The enemy has sunk your #{name}!" if attacker == 'Enemy'
    else
      return 'Hit!' if attacker = 'Player'
      return "The enemy attacked #{(x + 65).chr}#{y} and hit your #{name}!" if attacker == 'Enemy'
    end
  end

  def update_status(opponent)
    index = opponent.ships.find_index {|item| item.name == name} * 2 + 1
    opponent.status[index] = '■'.red * size + ' ' * (10 - size) + '  |'
  end
end