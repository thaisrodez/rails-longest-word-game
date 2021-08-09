require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def included?
    word = params[:word].upcase
    word.chars.all? do |letter|
      word.count(letter) <= params[:grid].count(letter)
    end
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @included = included?
    @english_word = english_word?
    @word = params[:word]
    @grid = params[:grid]
  end
end
