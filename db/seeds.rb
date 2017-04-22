# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
1000000.times do
  Dictionaries.create([{word: Faker::Lorem.word,
                        translation: Faker::Lorem.word,
                        note: Faker::Lorem.sentence,
                        created_at: Faker::Time.between(20.days.ago, Date.today, :all),
                        updated_at: Faker::Time.between(20.days.ago, Date.today, :all),
                        language_id: Faker::Number.between(1, 103),
                        category_id: Faker::Number.between(1, 199),
                        user_id: Faker::Number.between(45003, 158282)
                       }])
end
=end

=begin
533362.times do
  user = User.find_or_initialize_by(email: nil)
  user.email = Faker::Internet.email
  user.save
end
=end
