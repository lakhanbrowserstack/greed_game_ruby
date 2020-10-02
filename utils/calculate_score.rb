class Score
  def self.score(dice)
    $result = 0
    hash_score = {
        1 => 100,
        5 => 50,
        [1, 1, 1] => 1000,
        2=>0,
        3=>0,
        4=>0,
        6=>0
    }
    dice_count = Hash.new(false)
    dice.each do |elem|
      if dice_count[elem]
        dice_count[elem] += 1
      else
        dice_count[elem] = 1
      end
    end

    dice_count.each do |number, count|
      if number == 1 && count >= 3
        $result = hash_score[[1, 1, 1]]
        $result += (hash_score[1] * (count - 3))

      elsif count >= 3
        $result += number * 100
        $result += (hash_score[number]*(count-3))
      else
        if hash_score[number]
          $result += (hash_score[number] * count)
        end
      end
    end
    $result
  end
end
