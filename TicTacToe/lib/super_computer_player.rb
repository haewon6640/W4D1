require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    ttt = TicTacToeNode.new(game.board, mark)
    valid_moves = []
    ttt.children.each do |child|
      if child.winning_node?(mark)
        valid_moves.unshift(child.prev_move_pos) 
      elsif !child.losing_node?(mark)
        valid_moves.push(child.prev_move_pos)
      end
    end
    raise "There are no good moves!" if valid_moves.empty?
    return valid_moves[0]
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
