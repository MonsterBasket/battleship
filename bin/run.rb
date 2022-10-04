require_relative '../config/environment'

enemy = Player.new
player = Player.new
puts "         Enemy"
enemy.board.print_board enemy.status
puts "\n       Your board"
player.board.print_board player.status

player.ships.each {|ship| player.place_ship ship}
