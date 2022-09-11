require 'rails_helper'

#どのクラスのテストを実施するか？
RSpec.describe User, type: :model do
  #どのメソッドのテストであるか？
  describe '#total_score' do
    #create(:user)という処理をletに渡す
    #create(:user)はfactory_botの機能を使用しusersテーブルにテストデータを1件作成し、Userインスタンスに返す。
    let(:user1) { create(:user) }

    context 'user_scoresテーブルにデータがある場合' do
      #テストの前提条件を整える
      before do
        create(:user_score, user: user1, score: 4)
        create(:user_score, user: user1, score: 5)
        create(:user_score, user: user1, score: 6)
      end

      #テストケースをコーディング
      it 'スコアの合計を取得できる' do
        expect(user1.total_score).to eq 15
      end
    end

    context 'user_scoresテーブルにデータがない場合' do
      it 'スコアの合計は0である' do
        expect(user1.total_score).to eq 0
      end
    end
  end
end
