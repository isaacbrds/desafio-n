FactoryBot.define do
  factory :plate do
    serial { "FAA-1234" }
    time { Time.now.strftime("%H:%M") }
    paid { false }
    left { false }
  end
end
