require_relative 'logic'
require_relative 'ui'

# This class is responsible for the game logic
class Game
  def initialize(display, logic)
    @ui = display
    @logic = logic
    @player1 = display.player1
    @player2 = display.player2
  end

  def play
    loop do
      @logic.next_turn
      break if @logic.winner? || @logic.turn == 9
    end
    winner = @logic.turn.even? ? @player1 : @player2
    final_message = @logic.winner? ? "Congratulations #{winner}! You won!" : "It's a tie!"
    @ui.messages = [final_message, 'End of the game!']
    @ui.update_ui
    'Game Over'
  end
end
