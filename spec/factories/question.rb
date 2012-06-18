FactoryGirl.define do
  factory :question do
    sequence(:text) {|n| "Question #{n}" }
    display_order 0
    association :survey_section

    factory :question_in_group do
      association :question_group
    end
  end
end

