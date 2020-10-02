class Player
  attr_accessor :score
  def initialize
    @score = 0
  end

  def reachedFinalScore
    @score >= 3000
  end

end
