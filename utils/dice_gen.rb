class DiceGen
  def self.scoring_dices
    5.times.map{ rand(1..6) }
  end

  def self.non_scoring_dices(number)
    number.times.map{ rand(1..6) }
  end
end
