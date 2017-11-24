#!/usr/bin/ruby -w
# AI player for the game Connect Four written by Meredith Lind

#@board = JSON.parse(ARGV[1])
require 'json'
@board = JSON.parse("[[1,0,0,0,0,0,0],[2,0,0,0,0,0,0],[1,0,0,0,0,0,0],[2,0,0,0,0,0,0],[2,2,0,0,0,0,0],[1,1,0,0,0,0,0]]")

def is_valid?(y)
  get_next_opening(y) >= 0
end

def get_next_opening(y)
  col = get_column(y)
  # Starting at the end of the array, get the index of the first zero cell
  # If the column is full, it returns -1
  i = col.size - 1
  while i >= 0 do
    break if col[i] == 0
    i -= 1
  end
  i
end

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

puts "#{get_next_opening(0)}"
puts "#{is_valid?(0)}"
puts "#{get_next_opening(1)}"
puts "#{is_valid?(1)}"
puts "#{get_next_opening(2)}"
puts "#{get_next_opening(3)}"
puts "#{get_next_opening(4)}"
puts "#{get_next_opening(5)}"
puts "#{get_next_opening(6)}"
