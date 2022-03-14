require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  
    if board.over?
      return false if board.tied?
      return evaluator != board.winner
    end

    new_children = self.children

    if evaluator == next_mover_mark # my move
      new_children.all? {|child| child.losing_node?(evaluator)}
    else # opponent's move
      new_children.any? {|child| child.losing_node?(evaluator)}
    end

  end

  def winning_node?(evaluator)
    if board.over?
      return false if board.tied?
      return evaluator == board.winner
    end 
    
    new_children = self.children

    if evaluator == next_mover_mark
      new_children.any? {|child| child.winning_node?(evaluator)}
    else
      new_children.all? {|child| child.winning_node?(evaluator)}
    end 
  end


  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_arr = []
    nextMark = next_mover_mark == :o ? :x : :o
    (0..2).each do |i|
      (0..2).each do |j|
        if @board.empty?([i,j])
          temp_board = @board.dup
          temp_board[[i,j]] = @next_mover_mark
          child_arr << TicTacToeNode.new(temp_board, nextMark, [i,j])
        end
      end
    end
    child_arr
  end


end
