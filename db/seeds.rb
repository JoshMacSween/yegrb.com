# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Delete all previous entries
User.all.delete_all

# Create admin
User.create!(email: ENV["ADMIN_EMAIL"], password: ENV["ADMIN_PASS"], password_confirmation: ENV["ADMIN_PASS"], role: "admin", first_name: ENV["ADMIN_NAME"])