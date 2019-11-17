FactoryBot.define do
  factory :todo do
    title { Faker::Movies::StarWars.character }
    completed { Faker::Boolean.boolean }
  end

  factory :todo_active, class: Todo do
    title { Faker::Movies::StarWars.character }
    completed { false }
  end

  factory :todo_completed, class: Todo do
    title { Faker::Movies::StarWars.character }
    completed { true }
  end
end