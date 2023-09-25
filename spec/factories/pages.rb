FactoryBot.define do
  sequence(:name) { |n| "name#{n}" }
  #sequence :content, %w[*A* \\A\\ ((A/b\ [b]))].cycle

  factory :page do
    name
    title { "a_title" }
    content { "*[A]* \\[B]\\ ((A/a [B]))" }

    trait :invalid do
      name { '**&*' }
    end
  end
end

