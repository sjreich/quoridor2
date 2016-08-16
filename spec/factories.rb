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
end
