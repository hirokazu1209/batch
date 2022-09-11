class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks, comment: 'ゲーム内のランキング情報' do |t|
      # index: { unique: true } ...user_id1種類につき、ranksテーブルには1行のみ格納可能
      # on_restrict ...子テーブルから先にデータを削除しないとエラーになる様に設定する
      t.references :user, null: false, index: { unique: true }, foreign_key: { on_delete: :restrict, on_update: :restrict }, comment: 'ユーザー'
      t.integer :rank, null: false, default: 0, index: true, comment: 'ユーザーの順位'
      t.integer :score, null: false, default: 0, comment: 'このランクに至ったスコア'

      t.timestamps null: false
    end
  end
end
