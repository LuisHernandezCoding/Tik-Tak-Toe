# rubocop disable: Layout/LineLength

require_relative '../lib/logic'
require_relative '../lib/colors'
require_relative '../lib/ui'
require_relative '../lib/game'

describe 'Logic' do
  display = UI.new
  display.configure_players
  display.finished_scoreboard = true
  logic = Logic.new(0, 'K the Komputer', 'B the Bot', display)

  describe '#next_turn' do
    it 'should change the turn' do
      expect(logic.turn).to eql(0)
      logic.next_turn
      expect(logic.turn).to eql(1)
    end
  end

  describe '#winner?' do
    it 'should return false if there is no winner' do
      expect(logic.winner?).to eql(false)
    end
  end

  describe '#full?' do
    it 'should return false if the board is not full' do
      expect(logic.full?).to eql(false)
    end
  end
end
