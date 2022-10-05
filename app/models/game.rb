class Game
  attr_accessor :enemy, :player, :playing

  def initialize
    @playing = true
    @enemy = Player.new 'Enemy'
    @player = Player.new 'Player'
    init
    until !playing
      refresh
      attack
      defend
    end
    game_over
  end

  def init
    system('clear') || system('cls')
    player.board.print_board player.status
    player.ships.each {|ship| player.place_ship ship}
    enemy.ships.each {|ship| enemy.place_ship_random ship}
  end

  def refresh
    puts '         Enemy                      |'
    enemy.board.print_board enemy.status
    puts '                                    |'
    puts '       Your board                   |'
    player.board.print_board player.status
  end

  def attack
    print "\nWhere would you like to attack?"
    hit = player.attack enemy
    refresh
    puts "#{hit} Opponent's turn."
  end

  def defend
    puts "The enemy attacked #{}! It's a #{}!"
  end

  def game_over
    print "You #{}! Would you like to play again? (Y/N)"
    restart if gets.downcase[0] == "y"
  end

  def restart
    Game.new
  end
end
