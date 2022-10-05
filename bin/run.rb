require_relative '../config/environment'

enemy = Player.new
player = Player.new
player.board.print_board player.status
player.ships.each {|ship| player.place_ship ship}
enemy.ships.each {|ship| enemy.place_ship_random ship}
system('clear') || system('cls')
puts "         Enemy"
enemy.board.print_board enemy.status
puts "\n       Your board"
player.board.print_board player.status
