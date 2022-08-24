# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
@leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
@carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
@roxane_gay = Author.create!(name: "Roxane Gay", currently_alive: true, age_when_first_published: 30)
@book_1 = @carmen_maria_machado.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
@book_2 = @carmen_maria_machado.books.create!(name: "In the Dream House", length: 321, in_print: true)
@book_3 = @jane_austen.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
@book_4 = @jane_austen.books.create!(name: "Pride and Prejudice", length: 387, in_print: true)
@book_5 = @leslie_feinberg.books.create!(name: "Stone Butch Blues", length: 300, in_print: false)
@book_6 = @roxane_gay.books.create!(name: "Hunger", length: 400, in_print: true)

