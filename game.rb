require_relative './models/player'
require_relative './utils/turn'
require_relative './utils/calculate_score'

class Game
  attr_reader :players
  def initialize
    @players = {}
    @turns = 1
    @final_game = false

  end

  def createPlayers(number)
    i = 1
    number.times do
      @players[i]=Player.new
      i+=1
    end
  end
  
  def playGame
    until @final_game
      puts "Turn #{@turns}:"
      puts "-------------------------------------------"
      @final_game = Turn.createTurn(@players,@final_game)
      puts "-------------------------------------------"
      @turns+=1
    end
  end

  def finalGame
    Turn.finalTurn(@players)
  end

end



