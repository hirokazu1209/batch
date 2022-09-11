namespace :ranks do
  namespace :chapter2 do
    desc 'chapter2 ゲーム内のユーザーランキング情報を更新する'
    # {タスクA::タスクAの前に実行するタスクB}
    # environment config/environment.rbを読みこみ、productionやdevelopmentといった実行環境ごとの設定を反映
    task update: :environment do
      # 現在のランキング情報をリセット
      Rank.delete_all

      # ユーザーごとにスコアの合計を計算する
      user_total_scores = User.all.map do |user|
        # sum(&:score) は sum{ |user_score| user_score.score }と同義
        { user_id: user.id, total_score: user.user_scores.sum(&:score) }
      end

      # ユーザーごとのスコア合計の降順に並べ替え、そこからランキング情報を再作成する
      sorted_total_score_groups = user_total_scores
                              #同着ユーザーをグルーピングする処理
                              .group_by { |score| score[:total_score] }
                              #ハッシュのキーの値の降順で並び替えする処理
                              #-1をかけた値を基準に昇順で並び替えれば、降順での並び替えを実行できる
                              #_は未使用の値の場合記入する
                              .sort_by { |score, _| score * -1 }
                              #現状が二次元配列のため、構造をハッシュに変換する
                              .to_h
                              #ハッシュの値のみを抜き出す
                              .values

      #sorted_total_score_groups内の各スコアに順位を付与してranksテーブルに保存する
      #with_index(1)でグループごとに順位を割り当てる
      sorted_total_score_groups.each.with_index(1) do |scores, index|
        scores.each do |total_score|
          Rank.create(user_id: total_score[:user_id], rank: index, score: total_score[:total_score])
        end
      end
    end
  end
end