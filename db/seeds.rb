# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.destroy_all

tasks = [
  { title: 'first_task',  content: 'Content 1',  deadline_on: '2022-02-18', priority: :medium,  status: :not_started },
  { title: 'second_task', content: 'Content 2',  deadline_on: '2022-02-17', priority: :high,    status: :in_progress },
  { title: 'third_task',  content: 'Content 3',  deadline_on: '2022-02-16', priority: :low,     status: :completed },
  { title: 'fourth_task', content: 'Content 4',  deadline_on: '2022-03-01', priority: :high,    status: :not_started },
  { title: 'fifth_task',  content: 'Content 5',  deadline_on: '2022-03-05', priority: :low,     status: :in_progress },
  { title: 'sixth_task',  content: 'Content 6',  deadline_on: '2022-03-10', priority: :medium,  status: :completed },
  { title: 'seventh_task',content: 'Content 7',  deadline_on: '2022-03-15', priority: :high,    status: :not_started },
  { title: 'eighth_task', content: 'Content 8',  deadline_on: '2022-03-20', priority: :medium,  status: :in_progress },
  { title: 'ninth_task',  content: 'Content 9',  deadline_on: '2022-03-25', priority: :low,     status: :completed },
  { title: 'tenth_task',  content: 'Content 10', deadline_on: '2022-03-30', priority: :high,    status: :not_started },
]

tasks.each { |t| Task.create!(t) }