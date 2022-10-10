require_relative '../lib/colors'
require_relative '../lib/game'
require_relative '../lib/logic'
require_relative '../lib/ui'

def start_game
  display = UI.new
  display.update_ui
  display.configure_players
  display.finished_scoreboard = true
  display.messages = ['Press Enter to start the game', ' ']
  display.update_ui
  gets
  logic = Logic.new(display.players, display.player1, display.player2, display)
  Game.new(display, logic)
end

game = start_game
game.play
