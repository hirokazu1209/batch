module Chapter5
  class RankOrderMaker
    def each_ranked_user
      rank = 1
      previous_score = 0

      ranked_users.each do |user|
        rank += 1 if user.total_score < previous_score
        yield(user, rank)
        previous_score = user.total_score
      end
    end

    private

    def ranked_users
      User
        # 子テーブルのデータを後で必ず使用する場合は「include」を使用して先読みをすることで実行時間の高速化を図る
        .includes(:user_scores)
        .all
        .select { |user| user.total_score.nonzero? }
        .sort_by { |user| user.total_score * -1 }
    end
  end
end