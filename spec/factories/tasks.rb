FactoryBot.define do
  factory :task do
    title { 'Document preparation' }
    content { 'Create a proposal.' }
    deadline_on { '2022-02-18' }
    priority { :medium }
    status { :not_started }
  end

  factory :second_task, class: Task do
    title { 'send e-mail' }
    content { 'Send a sales email to a customer.' }
    deadline_on { '2022-02-17' }
    priority { :high }
    status { :in_progress }
  end

  factory :third_task, class: Task do
    title { 'third_task_title' }
    content { 'Third task content.' }
    deadline_on { '2022-02-16' }
    priority { :low }
    status { :completed }
  end
end
