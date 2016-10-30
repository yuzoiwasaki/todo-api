FactoryGirl.define do
  factory :todo do
    title "foo"
    description "bar"
    status 0
    created_at DateTime.now
    updated_at DateTime.now
  end
end
