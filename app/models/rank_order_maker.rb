class RankOrderMaker
  def each_ranked_user
    rank = 1
    previous_score = 0

    users_sorted_by_score.each do |user|
      rank += 1 if user.total_score < previous_score
      #ranks_updater.rbのcreate_ranksに書いた
      #Rank.create(user_id: user.id, rank: rank, score: user.total_score)を実行
      yield(user, rank)
      previous_score = user.total_score
    end
  end

  private

  def users_sorted_by_score
    User.all
    #スコアを獲得しているユーザーのみに絞り込み
    .select { |user| user.total_score.nonzero? }
    .sort_by { |user| user.total_score * -1 }
  end
end