require_relative './dice_gen'
require_relative './calculate_score'

class Turn

  ROUND_SCORE = 300
  FINAL_ROUND_SCORE = 3000
  @non_score_dices = [2, 3, 4, 6]
  @calculate = Score

  def self.askingUserToRoll(curr_score, count, total_score, i, player)
    while count > 0 and total_score>0
      print "Do you want to roll the non-scoring #{count} dices?(y/n):"
      choice = gets.chomp
      case choice
        when "y"
          dice = DiceGen.non_scoring_dices(count)
          print "player#{i} rolls: "
          puts dice.to_s
          curr_score = @calculate.score(dice)
          total_score  = curr_score == 0 ? 0 : curr_score+total_score
          print "score in this round: "
          puts curr_score
          print "total score: "
          puts (player.score+total_score).to_s+"\n"
          count = 0
          @non_score_dices.each do |elem|
            count+=dice.count(elem)
          end

        when "n"
          count = 0
          puts "player#{i} skipped the non-scoring dices!"
        else
          count = 0
          puts "Invalid input!!"

      end

    end
    yield total_score
    @curr_score = curr_score
  end

  def self.createTurn(players, final_game)
    players.each do |i, player|
      if !player.reachedFinalScore
        print "player #{i} rolls: "
        dice = DiceGen.scoring_dices
        puts dice.to_s
        total_score = 0
        curr_score = @calculate.score(dice)
        print "score in this round: "
        puts curr_score
        total_score+=curr_score
        print "total score: "
        puts (player.score+total_score).to_s+"\n"
        count = 0
        @non_score_dices.each do |elem|
          count+=dice.count(elem)
        end

        askingUserToRoll(curr_score, count, total_score, i, player){
            |t_score|
          total_score=t_score
        }

        player.score += total_score>=ROUND_SCORE ? total_score : 0
        puts "turn finished...\n\n"
        unless final_game
          final_game = player.reachedFinalScore
        end
      else
        puts "Player #{i} already reached 3000 points!!"
      end
    end
    final_game ? final_game : false
  end

  def self.finalTurn(players)
    players.each do |i, player|
      if !player.reachedFinalScore
        print "player #{i} rolls: "
        dice = DiceGen.scoring_dices
        puts dice.to_s
        total_score = 0
        curr_score = @calculate.score(dice)
        print "score in this round: "
        puts curr_score
        total_score+=curr_score
        print "total score: "
        puts (player.score+total_score).to_s+"\n"
        count = 0
        @non_score_dices.each do |elem|
          count+=dice.count(elem)
        end

        askingUserToRoll(curr_score, count, total_score, i, player){
            |t_score|
          total_score=t_score
        }


        if total_score>=ROUND_SCORE
          player.score+=total_score
        end
        puts "turn finished...\n\n"
    else
      puts "Player #{i} already reached 3000 points!!"
    end
      end
  end
end
