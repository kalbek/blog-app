# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { Faker::Avatar.image }
    bio { Faker::Lorem.paragraph }
    posts_counter { rand(0..100) } # Random value for posts_counter
  end
end
