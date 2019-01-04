FactoryBot.define do

  # Tracker
  #
  factory :tracker do
    transient do
      issue_custom_fields { nil }
    end

    sequence(:name) { |n| "Tracker ##{n}" }

    default_status { IssueStatus.first || FactoryBot.create(:issue_status) }

    after(:build) do |tracker, evaluator|
      tracker.custom_fields = evaluator.issue_custom_fields if evaluator.issue_custom_fields
    end
  end

  factory :enumeration do
    sequence(:name) { |n| "Enum #{n}" }

    trait :default do
      name { 'Default' }
      is_default { true }
    end
  end

  # IssueStatus
  #
  # factory :issue_status, class: 'IssueStatus' do
  factory :issue_status do
    sequence(:name) { |n| "Status ##{n}" }

    trait :closed do
      is_closed { true }
    end
  end

  # IssuePriority
  #
  factory :issue_priority, aliases: [:priority] do
    sequence(:name) { |n| "Priority #{%w[Low Normal High Urgent][n % 4]} #{n}" }
    active { true }
    sequence(:position)

    is_default { !IssuePriority.any? }

    trait :default do
      is_default { true }
    end

    trait :low do
      name { "Low" }
    end
    trait :high do
      name { "High" }
    end

  end


end
