module Ranker

  # score
  # =====
  # Calculates the score of a submission
  def calculate_score
    score = total_up_votes - total_down_votes
    order = Math.log([score.abs, 1].max, 10)
    if score > 0
      sign = 1
    elsif score < 0
      sign = -1
    else
      sign = 0
    end
    seconds = created_at.time.to_i - 1134028003
    (order + sign * seconds / 45000).round(7)
  end

end