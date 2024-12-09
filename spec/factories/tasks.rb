FactoryBot.define do
  factory :task do
    title { "Sample Task" }
    description { "This is a sample task description." }
    status { "open" }
    category { "general" }
    priority { "high" }
    association :user
  end
end
