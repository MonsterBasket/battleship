class Game
  attr_accessor :enemy, :player, :playing

  def initialize
    @playing = true
    @enemy = Enemy.new 'Enemy'
    @player = Player.new 'Player'
    @articles = []
    thr = Thread.new {@articles = Scraper.new.articles}
    init
    thr.join
    refresh
    attack while @playing
  end

  def init
    system('clear') || system('cls')
    player.board.print_board player.status
    player.ships.each { |ship| player.place_ship ship }
    enemy.ships.each { |ship| enemy.place_ship_random ship }
    puts 'Loading, please wait...'
  end

  def refresh
    history = @articles.length > 0 ? @articles.sample : {lines: []}
    system('clear') || system('cls')
    puts '         Enemy                      |'
    enemy.board.print_board enemy.status, (!!history[:title] ? (['', history[:title], ''] + history[:lines][0..8]) : [])
    puts "                                    |  #{!!history[:lines][8] ? history[:lines][8] : ''}"
    puts "       Your board                   |  #{!!history[:lines][9] ? history[:lines][9] : ''}"
    player.board.print_board player.status, (!!history[:lines][10] ? history[:lines][10..11] : [])
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
      game_over 'lost'
    end
  end

  def game_over(won)
    print "You #{won}! Would you like to play again? (Y/N) "
    answer = gets
    return restart if answer[0].downcase == 'y'
    if answer[0].downcase != 'n'
      puts 'You had TWO options, "Y", or "N"! Go away!'
    else
      puts 'Thanks for playing!'
    end
    false
  end

  def restart
    Game.new
  end
end
