# rubocop disable: Layout/LineLength

require_relative '../lib/colors'

describe 'Colors' do
  colors_array = %w[black red green yellow blue magenta cyan]
  colors_array.each do |color|
    describe color do
      it 'should return the word "Test" with correct color' do
        expect('test'.send(color)).to eql("\e[#{colors_array.index(color) + 30}mtest\e[0m")
      end
    end
  end
end
describe 'Background Colors' do
  background_colors_array = %w[bg_black bg_red bg_green bg_orange bg_blue bg_magenta bg_cyan]
  background_colors_array.each do |color|
    describe color do
      it 'should return the word "Test" with correct color' do
        expect('test'.send(color)).to eql("\e[#{background_colors_array.index(color) + 40}mtest\e[0m")
      end
    end
  end
end
describe 'Text Effects' do
  describe 'bold' do
    it 'should return the word "Test" with bold effect' do
      expect('test'.bold).to eql("\e[1mtest\e[22m")
    end
  end
  describe 'italic' do
    it 'should return the word "Test" with italic effect' do
      expect('test'.italic).to eql("\e[3mtest\e[23m")
    end
  end
  describe 'underline' do
    it 'should return the word "Test" with underline effect' do
      expect('test'.underline).to eql("\e[4mtest\e[24m")
    end
  end
  describe 'blink' do
    it 'should return the word "Test" with blink effect' do
      expect('test'.blink).to eql("\e[5mtest\e[25m")
    end
  end
end
describe 'No Colors' do
  it 'should return the word "Test" without colors' do
    expect('test'.no_colors).to eql('test')
  end
end

# rubocop enable: Layout/LineLength
