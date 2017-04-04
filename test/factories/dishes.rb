FactoryGirl.define do
  factory :dish do
    name { generate :string }
    description
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'factories', 'files', 'dish.jpg'), 'image/jpg') }
    dish_type 'soup'

    trait :salad do
      dish_type :salad
    end
  end
end
