# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.destroy_all
User.destroy_all

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

regular = User.create!(
  name: 'Regular User',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

statuses = [:not_started, :in_progress, :completed]
priorities = [:low, :medium, :high]

[admin, regular].each do |user|
  50.times do |i|
    user.tasks.create!(
      title: "#{user.name} Task #{i + 1}",
      content: "Content #{i + 1}",
      deadline_on: Date.today + i.days,
      priority: priorities[i % 3],
      status: statuses[i % 3]
    )
  end
end