FactoryGirl.define do
  factory :response_set do |f|
    f.association :survey
    f.association :user, :factory => :trainer
    f.association :kase
  end
end
