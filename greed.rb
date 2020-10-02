require_relative './game'

class Greed
  def initialize(players)
    @players = players
  end
  def playersReachedFinalRound
    score_reach = []
    @players.each do |key,player|
      if player.reachedFinalScore
        score_reach << key.to_s
      end
    end
    score_reach
  end

  def displayPlayerReached
    score_reach = playersReachedFinalRound
    players_reached_3000 = ""
    score_reach.each do |item|
      players_reached_3000+="player #{item}, "
    end
    players_reached_3000
  end

  def maxScoreCalculate
    scores = []
    @players.each do |key,player|
      scores << player.score
    end
    scores
  end

  def findWinnerPlayer
    scores = maxScoreCalculate
    maximum = scores.max
    scores.find_index(maximum)+1

  end

end


game = Game.new
players = game.players

greed = Greed.new(players)

print "Enter the number of players:"
n = gets.chomp.to_i
while n<2
  puts "Need more than one player to start the game..."
  n = gets.chomp.to_i
end

game.createPlayers(n)

game.playGame

puts "----------------------------------------------"
puts "Time for final Game...\n"


puts "-------------------------------------------------------------------------------------------------------"
puts greed.displayPlayerReached+"\n"
puts "Above players already reached 3000 and more points, so remaining players will participate in the final round!"
puts "--------------------------------------------------------------------------------------------------------"

game.finalGame

winner = "player "+greed.findWinnerPlayer.to_s
puts "--------------------------"
puts "Winner is #{winner}!!!"
puts "--------------------------"