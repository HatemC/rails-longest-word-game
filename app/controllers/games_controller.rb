 require "open-uri"

class GamesController < ApplicationController
  def new
    letters_array = ("A".."Z").to_a
    @letters =[]
    for i in (0..9)
    @letters << letters_array.sample(1)
    end
    return @letters.flatten!
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    test_word = JSON.parse(open(url).read)
    count_ok = 0
    params[:word].each_char do |letter|
    count_ok += 1 if params[:grid].include?(letter) && params[:word].count(letter) <= params[:grid].count(letter)
    end
    count_length = count_ok == params[:word].length ?  true : false
    if count_length && test_word["found"]
      @message = 'The word is valid according to the grid and is an English word'
    elsif count_length
      @message = 'The word is valid according to the grid, but is not a valid English word'
    else
      @message = 'The word can’t be built out of the original grid'
    end
    return @message
  end
end
