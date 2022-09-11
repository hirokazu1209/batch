FactoryBot.define do
  factory :user_score do
    #テストデータのリレーションを定義している
    association :user
    score { 1 }
    received_at { Time.current }
  end
end