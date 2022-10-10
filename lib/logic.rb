# frozen_string_literal: true

require_relative 'ui'
require_relative 'colors'

WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

# Class containing the logic of the game
class Logic
  attr_reader :board, :player1, :player2, :players
  attr_accessor :turn, :actual_symbol, :actual_player_name

  def initialize(players, player1, player2, ui_display)
    @players = players
    @turn = 0
    @player1 = player1
    @player2 = player2
    @ui_display = ui_display
    @actual_symbol = 'X'.bg_black.red
    @actual_player_name = @player1
  end

  def next_turn
    @actual_symbol = @turn.even? ? 'X'.bg_black.red : 'O'.bg_black.cyan
    @player_name = @turn.even? ? @player1 : @player2
    case @players
    when 0
      computer_pick(@actual_symbol)
    when 1
      @turn.even? ? player_turn : computer_pick(@actual_symbol)
    when 2
      player_turn
    end
  end

  def player_turn
    @ui_display.messages = ["#{@actual_player_name}, it's your turn!", 'Pick an empty number from 1 to 9']
    @ui_display.update_ui
    player_input = check_user_input.to_i
    @ui_display.board[player_input - 1] = @actual_symbol
    @ui_display.update_ui
    @turn += 1
  end

  def check_user_input
    player_input = gets.chomp.to_i
    while player_input.to_i < 1 || player_input.to_i > 9 || check_if_empty?(player_input.to_i) == false
      @ui_display.messages = ["#{@actual_player_name}, please pick a valid number!", 'Pick an empty number from 1 to 9']
      @ui_display.update_ui
      player_input = gets.chomp
    end
    player_input
  end

  def getting_player_name
    update_ui
    name = gets.chomp
    until name.length.between?(1, 20)
      @messages = ['Invalid name', 'Please try again']
      update_ui
      name = gets.chomp
    end
    name
  end

  def check_if_empty?(position)
    @ui_display.board[position - 1] == position.to_s.bg_black
  end

  def computer_pick(symbol)
    actual_computer_name = @turn.even? ? @player1 : @player2
    @ui_display.loading_animation("#{actual_computer_name.no_colors} is thinking...")
    computer_input = rand(1..9)
    p computer_input = rand(1..9) until check_if_empty?(computer_input)
    @ui_display.board[computer_input - 1] = symbol
    @ui_display.update_ui
    @turn += 1
  end

  def winner?
    board_no_color = @ui_display.board.map { |i| i.to_s.no_colors }
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? { |i| board_no_color[i - 1] == 'X' } || combination.all? { |i| board_no_color[i - 1] == 'O' }
    end
  end

  def full?
    @ui_display.board.none? { |i| i.to_s.no_colors.to_i.between?(1, 9) }
  end
end
