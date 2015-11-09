class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :guesses
  attr_accessor :word 
  attr_accessor :wrong_guesses
  def initialize(word, guesses='', wrong_guesses='')
    @word = word
    @guesses = guesses
    @wrong_guesses =wrong_guesses
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def word
    @word
  end
  
  def guess letter
    throw ArgumentError if letter.nil? || letter.empty? || letter !~ /[a-z]$/i
    
    letter = letter.downcase
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
  end
  
  def word_with_guesses
    result = ""
    @word.each_char { |c|
      if @guesses.include?(c) 
        result += c
      else
        result+="-"
      end
    }
    result
  end
  
  def check_win_or_lose
    return :lose if (@wrong_guesses.size == 7 )
    return :win if (@guesses.squeeze.size == @word.size)  
    :play
  end
end
