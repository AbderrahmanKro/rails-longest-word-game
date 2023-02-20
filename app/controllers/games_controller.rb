require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]

    valid_word = @answer.chars.all? { |letter| @letters.include?(letter) }

    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    english_word = json['found']

    if valid_word && english_word
      @score = @answer.length
      @message = "Congratulations! #{@answer} is a valid English word and can be built from the original grid."
    elsif valid_word
      @score = 0
      @message = "Sorry, #{@answer} is not a valid English word."
    else
      @score = 0
      @message = "Sorry, #{@answer} cannot be built from the original grid."
    end
  end
end
