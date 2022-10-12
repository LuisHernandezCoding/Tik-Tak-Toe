require_relative 'logic'
require_relative 'colors'

TITLE = 'Tic Tac Toe Game'.yellow.bold.center(64)
CREDITS = 'By: @LuisHernandezCoding'.yellow.bold.center(64)
SIDE_LINE = ' ' * 12
MARGIN = ' ' * 4
SEPARATOR = MARGIN + ('_'.bg_orange.bold * 72)
LEFT_BOARD_MARGIN = ' '.bg_cyan.bold * 31
RIGHT_BOARD_MARGIN = ' '.bg_cyan.bold * 30
FRAME = '+'.bg_black.bold * 50
BLINK_SYMBOL = '++'.bg_black.bold

ORANGE_FULL_LINE = MARGIN + (' '.bg_orange * 72)
ORANGE_FRAME_LINE = MARGIN + (' '.bg_orange * 11) + FRAME + (' '.bg_orange * 11)
ORANGE_TITLE_LINE = MARGIN + (' '.bg_orange * 11) + BLINK_SYMBOL + TITLE + BLINK_SYMBOL + (' '.bg_orange * 11)
ORANGE_CREDITS_LINE = MARGIN + (' '.bg_orange * 11) + BLINK_SYMBOL + CREDITS + BLINK_SYMBOL + (' '.bg_orange * 11)

CYAN_FULL_LINE = MARGIN + (' '.bg_cyan * 72)
CYAN_FRAME_LINE = MARGIN + (' '.bg_cyan * 11) + FRAME + (' '.bg_cyan * 11)
CYAN_LEFT_LINE = MARGIN + (' '.bg_cyan * 11) + BLINK_SYMBOL
CYAN_RIGHT_LINE = BLINK_SYMBOL + (' '.bg_cyan * 11)

BLACK_FULL_LINE = MARGIN + (' '.bg_black * 72)

# Class containing the UI of the game
class UI
  attr_accessor :messages, :player1, :player2, :players, :board, :finished_scoreboard, :scoreboard

  def initialize
    @messages = @scoreboard = @scoreboard_display = [' ', ' ']
    @board = (1..9).to_a.map { |i| i.to_s.bg_black }
    @player1 = @player2 = @players = nil
    @finished_scoreboard = false
  end

  def update_ui
    system 'clear' or system 'cls'
    show_header
    show_message
    show_board if @finished_scoreboard
    show_scoreboard
    show_input_bar if @finished_scoreboard
  end

  def show_header
    puts
    puts ORANGE_FULL_LINE, ORANGE_FRAME_LINE, ORANGE_TITLE_LINE
    puts ORANGE_CREDITS_LINE, ORANGE_FRAME_LINE, SEPARATOR
  end

  def show_message
    puts CYAN_FULL_LINE
    puts CYAN_LEFT_LINE + @messages[0].red.bold.center(64) + CYAN_RIGHT_LINE
    puts CYAN_LEFT_LINE + @messages[1].red.bold.center(64) + CYAN_RIGHT_LINE
    puts CYAN_FULL_LINE
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Layout/LineLength
  def show_board
    puts MARGIN + LEFT_BOARD_MARGIN + ' '.bg_black.bold + @board[6] + ' | '.bg_black.bold + @board[7] + ' | '.bg_black.bold + @board[8] + ' '.bg_black.bold + RIGHT_BOARD_MARGIN
    puts MARGIN + LEFT_BOARD_MARGIN + '---+---+---'.bg_black.bold + RIGHT_BOARD_MARGIN
    puts MARGIN + LEFT_BOARD_MARGIN + ' '.bg_black.bold + @board[3] + ' | '.bg_black.bold + @board[4] + ' | '.bg_black.bold + @board[5] + ' '.bg_black.bold + RIGHT_BOARD_MARGIN
    puts MARGIN + LEFT_BOARD_MARGIN + '---+---+---'.bg_black.bold + RIGHT_BOARD_MARGIN
    puts MARGIN + LEFT_BOARD_MARGIN + ' '.bg_black.bold + @board[0] + ' | '.bg_black.bold + @board[1] + ' | '.bg_black.bold + @board[2] + ' '.bg_black.bold + RIGHT_BOARD_MARGIN
    puts CYAN_FULL_LINE
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Layout/LineLength

  def show_scoreboard
    @finished_scoreboard ? (puts @scoreboard_display) : (print @scoreboard_display[0])
  end

  def update_scoreboard(status)
    @scoreboard = [@players, ' ', ' '] if status == 'players'
    @scoreboard[1] = @player1 if status == 'naming1'
    @scoreboard[2] = @player2 if status == 'naming2'
    update_scoreboard_display(status)
    update_ui
  end

  def update_scoreboard_display(status)
    @scoreboard_display = ["#{MARGIN + MARGIN.bg_cyan} #{'Players:'.green.bold} ", CYAN_FULL_LINE] if status == 'start'
    @scoreboard_display[0] += "#{@players.to_s.green.bold}  #{MARGIN.bg_cyan} " if status == 'players'
    @scoreboard_display[0] += @player1.center(21).bold.red + MARGIN.bg_cyan if status == 'naming1'
    @scoreboard_display[0] += @player2.center(21).bold.cyan + MARGIN.bg_cyan if status == 'naming2'
  end

  def show_input_bar
    puts BLACK_FULL_LINE
    print MARGIN + '>> '.bg_black.bold
  end

  def configure_players
    @messages = ['How many players?', '0, 1 or 2?']
    update_scoreboard('start')
    @players = gets.to_i
    while @players.negative? || @players > 2
      @messages = ['Invalid number of players', 'Try again:']
      update_ui
      @players = gets.to_i
    end
    update_scoreboard('players')
    configuring_player_names(@players)
  end

  def configuring_player_names(players)
    if players.zero?
      naming(1, true)
      naming(2, true)
    elsif players != 0
      naming(1, false)
      naming(2, players == 1)
    end
  end

  def naming(player_number, is_a_computer)
    name = player_number == 1 ? 'K the Komputer' : 'B the Bot'
    if is_a_computer
      loading_animation('Thinking a good name for the CPU')
    else
      @messages = ["What's the name of player #{player_number}?", '']
      update_ui
      name = getting_player_name
    end
    player_number == 1 ? @player1 = name : @player2 = name
    update_scoreboard("naming#{player_number}")
  end

  def getting_player_name
    name = gets.chomp
    if name.empty? || name.length > 20
      @messages = ['Invalid name', 'Try again:']
      update_ui
      name = gets.chomp
    end
    name
  end

  def loading_animation(string)
    3.times do |i|
      @messages = [string, "#{'|*| ' * (i + 1)}Loading#{' |*|' * (i + 1)}"]
      update_ui
      sleep 0.3
    end
    puts
  end
end
