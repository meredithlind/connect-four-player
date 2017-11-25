#!/usr/bin/ruby -w
# AI player for the game Connect Four written by Meredith Lind

require 'json'
@board = JSON.parse(ARGV[1])
@player = ARGV[3]

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

def vertical_victory
  row = 0
  until row == 2 do
    col = 0
    until col == 6 do
      if @board[row][col] != 0 &&
        @board[row][col] == @board[row+1][col] &&
        @board[row][col] == @board[row+2][col] &&
        @board[row][col] == @board[row+3][col]
        return @board[row][col]
      end
      col += 1
    end
    row += 1
  end
  return 0
end

def horizontal_victory
  row = 0
  until row == 5 do
    col = 0
    until col == 3 do
      if @board[row][col] != 0 &&
        @board[row][col] == @board[row][col+1] &&
        @board[row][col] == @board[row][col+2] &&
        @board[row][col] == @board[row][col+3]
        return @board[row][col]
      end
      col += 1
    end
    row += 1
  end
  return 0
end

def diagonal_victory
  col = 0
  until col == 3 do
    # Check for descending horizontal
    row = 0
    until row == 2 do
      if @board[row][col] != 0 &&
        @board[row][col] == @board[row+1][col+1] &&
        @board[row][col] == @board[row+2][col+2] &&
        @board[row][col] == @board[row+3][col+3]
        return @board[row][col]
      end
      row += 1
    end

    # Check for ascending horizontal
    row = 3
    until row == 5 do
      if @board[row][col] != 0 &&
        @board[row][col] == @board[row-1][col+1] &&
        @board[row][col] == @board[row-2][col+2] &&
        @board[row][col] == @board[row-3][col+3]
        return @board[row][col]
      end
      row += 1
    end
    col += 1
  end
  return 0
end

def win?(player)
  if player = 'player-one'
    player = 1
  else
    player = 2
  end

  horizontal_victory == player || vertical_victory == player || diagonal_victory == player
end

# Minimax algorithm
def score(game, depth)
  if game.win?(@player)
    return 10 - depth
  elsif game.win?(@opponent)
    return depth - 10
  else
    return 0
  end
end

def minimax(game, depth)
  return score(game) if game.over?
  depth += 1
  scores = [] # an array of scores
  moves = []  # an array of moves

  # Populate the scores array, recursing as needed
  game.get_available_moves.each do |move|
    possible_game = game.get_new_state(move)
    scores.push minimax(possible_game, depth)
    moves.push move
  end

  # Do the min or the max calculation
  if game.active_turn == @player
    # This is the max calculation
    max_score_index = scores.each_with_index.max[1]
    @choice = moves[max_score_index]
    return scores[max_score_index]
  else
    # This is the min calculation
    min_score_index = scores.each_with_index.min[1]
    @choice = moves[min_score_index]
    return scores[min_score_index]
  end
end

rand = rand(0...@board[0].size)

until is_valid?(rand)
  rand = rand(0...@board[0].size)
end

exit(rand)
