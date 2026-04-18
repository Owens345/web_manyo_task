FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    name { 'Test User' }
    email { generate(:email) }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'Admin User' }
    email { generate(:email) }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end

  factory :task do
    title { 'Document preparation' }
    content { 'Create a proposal.' }
    deadline_on { '2022-02-18' }
    priority { :medium }
    status { :not_started }
    association :user
  end

  factory :second_task, class: Task do
    title { 'send e-mail' }
    content { 'Send a sales email to a customer.' }
    deadline_on { '2022-02-17' }
    priority { :high }
    status { :in_progress }
    association :user
  end

  factory :third_task, class: Task do
    title { 'third_task_title' }
    content { 'Third task content.' }
    deadline_on { '2022-02-16' }
    priority { :low }
    status { :completed }
    association :user
  end

  factory :label do
    name { 'Test Label' }
    association :user
  end
end
