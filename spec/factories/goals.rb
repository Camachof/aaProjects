FactoryGirl.define do
  factory :goal do
    title { Faker::Book.title }
    body { Faker::Hipster.paragraphs }
    status { false }
    user_id {1}

    factory :public_goal do
      confidential { false }
    end

    factory :private_goal do
      confidential { true }
    end
  end
end
