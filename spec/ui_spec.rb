# rubocop disable: Layout/LineLength

require_relative '../lib/ui'
require_relative '../lib/colors'

describe 'UI updates' do
  ui = UI.new
  ui.update_ui

  describe '#update_ui' do
    it 'should update the UI' do
      expect(ui.board).to eql((1..9).to_a.map { |i| i.to_s.bg_black })
      expect(ui.messages).to eql([' ', ' '])
      expect(ui.player1).to eql(nil)
      expect(ui.player2).to eql(nil)
      expect(ui.finished_scoreboard).to eql(false)
      expect(ui.players).to eql(nil)
    end
  end

  describe '#update_board' do
    it 'should update the board' do
      ui.configure_players
      ui.board[0] = 'X'.bg_black
      expect(ui.board).to eql(['X'.bg_black, (2..9).to_a.map { |i| i.to_s.bg_black }].flatten)
    end
  end

  describe '#update_messages' do
    it 'should update the messages' do
      ui.messages = ['Player 1', 'Please enter a number']
      expect(ui.messages).to eql(['Player 1', 'Please enter a number'])
    end
  end
end

describe 'UI configuration' do
  describe '#configure_players' do
    it 'should configure the players' do
      ui = UI.new
      ui.update_ui
      ui.configure_players
      expect(ui.players).not_to eql(nil)
      expect(ui.player1).not_to eql(nil)
      expect(ui.player2).not_to eql(nil)
    end
  end

  describe '@scoreboard array' do
    ui = UI.new
    ui.update_ui

    it 'checks the scoreboard array if is not finished' do
      expect(ui.scoreboard).to eql([' ', ' '])
    end
    it 'checks the scoreboard array if is finished' do
      ui.configure_players
      expect(ui.scoreboard).to eql([ui.players, ui.player1, ui.player2])
    end
  end
end
