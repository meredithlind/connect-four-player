#!/usr/bin/ruby -w
# AI player for the game Connect Four written by Meredith Lind

#@board = JSON.parse(ARGV[1])
require 'json'
@board = JSON.parse("[[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[2,2,0,0,0,0,0],[1,1,0,0,0,0,0]]")

def get_column(y)
  col = []
  i = 0
  # Ensure the column number is valid for the board
  if y < @board[0].size
    # Iterate through each row, plucking the element from the given column
    while i < @board.size  do
      col << @board[i][y]
      i += 1
    end
  end
  col
end


puts "#{get_column(0)}"
puts "#{get_column(1)}"
puts "#{get_column(2)}"
puts "#{get_column(3)}"
puts "#{get_column(4)}"
