require_relative '../../config/environment'

class Board

  def print
    grid = Array.new(10, Array.new(10, " "))
    borders = Array.new(10, Array.new(9,"|"))

    puts "  A|B|C|D|E|F|G|H|I|J ".underline
    grid.each_with_index do |row, a|
      print "#{a}"+"|".on_blue
      row.each_with_index do |col, b|
        print "#{col}#{borders[a][b]}".underline.on_blue
      end
      puts "|".on_blue
    end
    nil
  end


    puts "  A|B|C|D|E|F|G|H|I|J ".black.on_blue.underline
    puts "0| | | | | | | | | | |"
    puts "1| | | | | | | | | | |"
    puts "2| | | | | | | | | | |"
    puts "3| | | | | | | | | | |"
    puts "4| | | | | | |▲| | | |"
    puts "5| | | | | | |█| | | |"
    puts "6| |◄■■■■■►| |█| | | |"
    puts "7| | | | | | |█| | | |"
    puts "8| | | | | | |▼| | | |"
    puts "9| | | | | | | | | | |"
  end
end
# X = hit (but in red)
# 7 = • = miss
# 30 = ▲ = top
# 31 = ▼ = bottom
# 16 = ► = right
# 17 = ◄ = left
# 219 = █ = vertical
# 254 = ■ = horizontal (including dividing lines between pieces)