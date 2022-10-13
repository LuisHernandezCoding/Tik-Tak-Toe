require_relative '../lib/colors'
require_relative '../lib/game'
require_relative '../lib/logic'
require_relative '../lib/ui'

describe 'Game' do
  display = UI.new
  display.players = 0
  display.update_scoreboard('players')
  display.configuring_player_names(0)
  display.finished_scoreboard = true
  logic = Logic.new(0, 'K the Komputer', 'B the Bot', display)

  describe '#play' do
    it 'should loop until there is a winner or a draw' do
      game = Game.new(display, logic)
      expect(game.play).to eql('Game Over')
    end
  end
end
