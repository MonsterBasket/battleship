class Game
  attr_accessor :enemy, :player, :playing

  def initialize
    @playing = true
    @enemy = Enemy.new 'Enemy'
    @player = Player.new 'Player'
    init
    attack while @playing
  end

  def init
    system('clear') || system('cls')
    player.board.print_board player.status
    player.ships.each {|ship| player.place_ship ship}
    enemy.ships.each {|ship| enemy.place_ship_random ship}
    refresh
  end

  def refresh
    system('clear') || system('cls')
    puts '         Enemy                      |'
    enemy.board.print_board enemy.status
    puts '                                    |'
    puts '       Your board                   |'
    player.board.print_board player.status
  end

  def attack
    print "\nWhere would you like to attack? "
    player_hit, player_win = player.attack enemy
    if player_win
      refresh
      puts player_hit
      @playing = false
      return game_over 'won'
    end
    hit, enemy_win = enemy.target player
    refresh
    puts player_hit
    puts hit
    if enemy_win
      @playing = false
      return game_over 'lost'
    end
  end

  def game_over(won)
    print "You #{won}! Would you like to play again? (Y/N) "
    answer = gets
    return restart if answer[0].downcase == 'y'
    if answer[0].downcase != 'n'
      puts "You had TWO options, \"Y\", or \"N\"! Go away!" if answer[0].downcase != 'n'
    else
      puts 'Thanks for playing!'
    end
  end

  def restart
    Game.new
  end
end
