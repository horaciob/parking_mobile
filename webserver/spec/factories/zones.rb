FactoryGirl.define do
  factory :zone, class: Zone  do
    name "test"
    number  300
    unit_price 5
    unit_time  30
  end
end
