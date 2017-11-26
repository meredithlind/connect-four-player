#!/usr/bin/ruby -w
# AI player for the game Connect Four written by Meredith Lind

require 'json'
@board = JSON.parse(ARGV[1])
@player = ARGV[3]

if @player == 'player-one'
  @player = 1
else
  @player = 2
end


def is_valid?(y)
  get_next_opening(y) >= 0 && get_next_opening(y) < @board.size
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

def get_next_smart_move
  i = 0
  while i < @board[0].size do
    j = get_next_opening(i) + 1
    return i if j < @board.size && @board[j][i] == @player && is_valid?(i)
    i += 1
  end
  i
end

move = get_next_smart_move

unless is_valid?(move)
  move = rand(0...@board[0].size)
end

exit(move)
