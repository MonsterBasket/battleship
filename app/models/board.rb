class Board
  attr_accessor :coords, :borders

  def initialize
    @coords = []
    @borders = []
    10.times do
      @coords << Array.new(10, " ")
      @borders << Array.new(9, "|")
    end
  end

  def print_board(status)
    puts '   ' + 'A|B|C|D|E|F|G|H|I|J'.underline
    coords.each_with_index do |row, a|
      print " #{a}" + '|'.on_blue
      row.each_with_index do |col, b|
        print "#{col}#{borders[a][b]}".underline.on_blue
      end
      puts '|'.on_blue + "  " + status[a]
    end
  end
end

# puts "  A|B|C|D|E|F|G|H|I|J "
# puts "0| | | | | | | | | | |"
# puts "1| | | | | | | | | | |"
# puts "2| | | | | | | | | | |"
# puts "3| | | | | | | | | | |"
# puts "4| | | | | | |▲| | | |"
# puts "5| | | | | | |█| | | |"
# puts "6| |◄■■■■■►| |█| | | |"
# puts "7| | | | | | |█| | | |"
# puts "8| | | | | | |▼| | | |"
# puts "9| | | | | | | | | | |"

# X = hit (but in red)
# 7 = • = miss
# 30 = ▲ = top
# 31 = ▼ = bottom
# 16 = ► = right
# 17 = ◄ = left
# 219 = █ = vertical
# 254 = ■ = horizontal (including dividing lines between pieces)