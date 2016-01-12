require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'display.rb'

class Game

  def initialize(player1, player2)
    @player1 = Player.new(player1, :white)
    @player2 = Player.new(player2, :black)
    @current_player = @player1
    @display = Display.new
    @board = Board.new
  end

  def play
    until over?
      take_turn
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end

  def take_turn
    valid_move = false
    until valid_move
      @display.render_board(@board.grid)
      selected = @display.get_input
      #debugger
      if selected
        if @display.valid_moves.include?(selected)
          valid_move = true
          @board.move(@selected_piece, selected)
        elsif selected && ((@board.grid[selected[0]][selected[1]].nil?) || (@board.grid[selected[0]][selected[1]].color != @current_player.color))
          @display.valid_moves = []
          @selected_piece = nil
        elsif
          @display.valid_moves = @board.grid[selected[0]][selected[1]].valid_moves
          @selected_piece = [selected[0], selected[1]]
        end
      end
    end

    @display.valid_moves = []
    @selected_piece = nil
  end

  def over?
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  the_game = Game.new("Eric", "Rynan")
  the_game.play
end