class Game
  attr_accessor :enemy, :player, :playing

  def initialize
    @playing = true
    @enemy = Player.new 'Enemy'
    @player = Player.new 'Player'
    init
    until !playing
      attack
    end
    game_over
  end

  def init
    system('clear') || system('cls')
    player.board.print_board player.status
    player.ships.each {|ship| player.place_ship ship}
    enemy.ships.each {|ship| enemy.place_ship_random ship}
    refresh
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
    player_hit = player.attack enemy
    defend player_hit
  end

  def defend(player_hit)
    puts "work in progress, please enter Enemy's attack"
    hit = enemy.attack player
    refresh
    puts player_hit
    puts hit
  end

  def game_over
    print "You #{}! Would you like to play again? (Y/N)"
    restart if gets.downcase[0] == "y"
  end

  def restart
    Game.new
  end
end
