require  "open-uri"



class GamesController < ApplicationController
  def new
    @alphabet = ('a'..'z').to_a
    @letters = Array.new(10) { @alphabet.sample }
  end

  def score
    @word = params[:word]
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = URI.open(@url).read
    response = JSON.parse(response)
    @english_word = response["found"]
    @letters = params[:letters].gsub!(" "," ")
    if @english_word && is_included?(@word ,@letters)
      @result = "The word is valid according to the grid, and it is avalid English word"
    elsif is_included?(@word ,@letters)
      @result ="The word is valid according to the grid, but is not a valid English word"
    else
      @result = "The word can't be built out of the original grid"
     end

  end
  private

  def is_included?(word ,letters)
    word.each_char.all? {|letter| letters.include?(letter) }
  end
end
