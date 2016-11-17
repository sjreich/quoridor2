FactoryGirl.define do
  factory :user do
    username 'player'
    password 'password'
    email 'player@example.com'
  end

  factory :game do
    association :player1, factory: :user
    association :player2, factory: :user
  end

  factory :move do
    variety :translation
    player 1
    x 1
    y 0
  end
end
