class User < ApplicationRecord
  has_many :user_scores
  has_one :rank

  def total_score
    #インスタンス変数 ||=...診断結果のキャッシュを保持することができる
    #メソッド2回目以降に呼び出された速度向上が期待できる
    @total_score ||= user_scores.sum(&:score)
  end
end